<template>
  <span v-if="!standalone"
        v-bind:class="['t2s', isSpeaking ? 'btn-speaking' : 'btn-speaker']"
        v-bind:title="!isSpeaking ? 'Lire texte' : 'Arreter la lecture'"
        @click="!isSpeaking ? speak() : stop()">
  </span>

</template>

<script>
const Speech = window.speechSynthesis;

export default {
  name: "text2Speech",
  props: {
    standalone: true,
    text: {
      type: String,
      required: false
    }
  },
  data() {
    return {
      isSpeaking: false,
      voices: null,
      rate: 1,
      pitch: 1,
      texts: []
    };
  },
  created() {
    this.voices = window.speechSynthesis
      .getVoices()
      .filter(v => v.localService);

    this.$bus.$on("t2s-speak", this.addText);
    this.$bus.$on("t2s-stop", this.cancelSpeak);
    this.$bus.$on("t2s-cancel", this.stop);
    this.$bus.$on("t2s-clear", this.clear);

  },
  beforeDestroy() {
    this.$bus.$off(["t2s-speak", "t2s-cancel"]);
  },
  methods: {
    initSpeaker(text, last, id) {
      const text2Speech = new SpeechSynthesisUtterance(text);
      text2Speech.lang = "fr-FR";
      text2Speech.pitch = this.pitch;
      text2Speech.rate = this.rate;

      if(last){
        text2Speech.addEventListener('end', e => {
            this.$bus.$emit("t2s-done-" + id);
            this.speak();
        });
      }

      return text2Speech;
    },

    addText(text, id) {
      this.texts.push({
        id,
        phrases: text
          .split(".")
          .map(p => p.trim())
          .filter(p => p.length > 0)
      });
      if (!this.isSpeaking) {
        this.speak();
      }
    },

    cancelSpeak(id) {
      const textIdx = this.texts.findIndex(t => t.id === id);
      if (textIdx > -1) {
        this.texts.splice(textIdx, 1);
      }
    },

    speak() {
      if (!Speech.speaking) {
        this.isSpeaking = true;
        while (this.texts.length > 0){
          const currentText = this.texts.shift();
          const nbPhr = currentText.phrases.length;

          this.$bus.$emit("t2s-speaking-" + currentText.id);
          currentText.phrases.forEach((phr,i) => {
            const text2Speech = this.initSpeaker(phr, i === (nbPhr-1), currentText.id);
            Speech.speak(text2Speech);
          });
        }; // Each msg for the Speech
        this.isSpeaking = false;
      } else {
        this.$bus.$emit(
          "msg-info",
          "En cours de lecture !\n Un peu de patience ..."
        );
      }
    },

    stop() {
      Speech.cancel();
      this.isSpeaking = false;
    },
    
    clear() {
      this.stop();
      this.texts.length = 0;
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.t2s {
  /* margin: 4px; */
  /* position: static; */
  /* background: brown; */
  margin-right: 4px;
  height: 32px;
  width: 32px;
  background-size: 100%;
  background-position: center center !important;
  background-repeat: no-repeat !important;
  cursor: pointer;
}

.btn-speaker {
  /* background: brown; */
  background-image: url(data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTYuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4PSIwcHgiIHk9IjBweCIgd2lkdGg9IjMycHgiIGhlaWdodD0iMzJweCIgdmlld0JveD0iMCAwIDQ3NS4wODIgNDc1LjA4MSIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNDc1LjA4MiA0NzUuMDgxOyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+CjxnPgoJPGc+CgkJPHBhdGggZD0iTTIwMC45OTksNjMuOTUyYy00Ljk0NiwwLTkuMjI5LDEuODEyLTEyLjg0Nyw1LjQyNmwtOTUuMDc0LDk1LjA3NUgxOC4yNzZjLTQuOTUyLDAtOS4yMzQsMS44MTItMTIuODUsNS40MjQgICAgQzEuODA5LDE3My40OTMsMCwxNzcuNzc4LDAsMTgyLjcyNnYxMDkuNjNjMCw0Ljk0OSwxLjgwOSw5LjIzMyw1LjQyNiwxMi44NDhjMy42MTksMy42MTcsNy45MDIsNS40MjcsMTIuODUsNS40MjdoNzQuNzk4ICAgIGw5NS4wNzQsOTUuMDc4YzMuNjE3LDMuNjEsNy45LDUuNDI0LDEyLjg0Nyw1LjQyNGM0Ljk1MiwwLDkuMjM0LTEuODEzLDEyLjg1LTUuNDI0YzMuNjE3LTMuNjE0LDUuNDI2LTcuOTAxLDUuNDI2LTEyLjg0N1Y4Mi4yMjggICAgYzAtNC45NDgtMS44MDktOS4yMzQtNS40MjItMTIuODVDMjEwLjIzLDY1Ljc2NCwyMDUuOTUxLDYzLjk1MiwyMDAuOTk5LDYzLjk1MnoiIGZpbGw9IiM5MzNFQzUiLz4KCQk8cGF0aCBkPSJNMzE2Ljc2OSwyNzcuOTM2YzguMDkzLTEyLjQ2NywxMi4xMzUtMjUuOTMsMTIuMTM1LTQwLjM5NXMtNC4wNDItMjcuOTkyLTEyLjEzNS00MC41NTYgICAgYy04LjA5NC0xMi41NjItMTguNzkxLTIxLjQxLTMyLjEyMS0yNi41NTFjLTEuOTAyLTAuOTQ5LTQuMjg0LTEuNDI3LTcuMTM5LTEuNDI3Yy00Ljk0NCwwLTkuMjMyLDEuNzYyLTEyLjg0Nyw1LjI4MiAgICBjLTMuNjEsMy41MjEtNS40MjcsNy44NTItNS40MjcsMTIuOTljMCwzLjk5NywxLjE0Myw3LjM3NiwzLjQzMiwxMC4xMzdjMi4yODMsMi43NjIsNS4wNDEsNS4xNDIsOC4yODIsNy4xMzkgICAgYzMuMjMsMS45OTgsNi40NjgsNC4xODgsOS43MDgsNi41NjdjMy4yMzgsMi4zOCw1Ljk5Niw1Ljc1OCw4LjI3OCwxMC4xMzVjMi4yNzYsNC4zOCwzLjQyNiw5LjgwNCwzLjQyNiwxNi4yNzcgICAgYzAsNi40NzEtMS4xNDMsMTEuODk2LTMuNDI2LDE2LjI3NmMtMi4yODIsNC4zODEtNS4wNCw3Ljc1NS04LjI3OCwxMC4xNGMtMy4yNCwyLjM3OS02LjQ3OCw0LjU2OS05LjcwOCw2LjU2NyAgICBjLTMuMjQxLDEuOTkyLTUuOTk5LDQuMzc3LTguMjgyLDcuMTMyYy0yLjI4MiwyLjc2NS0zLjQzMiw2LjE0My0zLjQzMiwxMC4xNGMwLDUuMTQ0LDEuODE2LDkuNDcsNS40MjcsMTIuOTkgICAgYzMuNjE0LDMuNTIxLDcuOTAyLDUuMjg4LDEyLjg0Nyw1LjI4OGMyLjg1NCwwLDUuMjM2LTAuNDc5LDcuMTM5LTEuNDI0QzI5Ny45NzgsMjk5LjMwNCwzMDguNjc5LDI5MC40MDMsMzE2Ljc2OSwyNzcuOTM2eiIgZmlsbD0iIzkzM0VDNSIvPgoJCTxwYXRoIGQ9Ik0zNzcuNzI4LDMxOC4xOTRjMTYuMTgtMjQuNjQ2LDI0LjI3My01MS41MzEsMjQuMjczLTgwLjY1NGMwLTI5LjEyNC04LjA5NC01Ni4wMDUtMjQuMjczLTgwLjY2NiAgICBjLTE2LjE3Ny0yNC42NDUtMzcuNi00Mi41ODMtNjQuMjQxLTUzLjgxNWMtMi40NzEtMC45NS00Ljk0OC0xLjQyNy03LjQxNi0xLjQyN2MtNC45NDgsMC05LjIzNiwxLjgwOS0xMi44NTQsNS40MjYgICAgYy0zLjYxMywzLjYxNi01LjQyNCw3Ljg5OC01LjQyNCwxMi44NDdjMCw3LjQyNCwzLjcxMywxMy4wMzksMTEuMTM5LDE2Ljg0OWMxMC42NTcsNS41MTgsMTcuODg4LDkuNzA1LDIxLjY5MywxMi41NTkgICAgYzE0LjA4OSwxMC4yOCwyNS4wNzcsMjMuMTczLDMyLjk3NiwzOC42ODZjNy44OTgsMTUuNTE0LDExLjg0OCwzMi4wMjYsMTEuODQ4LDQ5LjUzN2MwLDE3LjUxMi0zLjk0OSwzNC4wMjMtMTEuODQ4LDQ5LjUzNiAgICBjLTcuODk4LDE1LjUxNi0xOC44OTQsMjguNDA3LTMyLjk3NiwzOC42ODRjLTMuODA2LDIuODU3LTExLjAzNiw3LjA0My0yMS42OTMsMTIuNTYzYy03LjQyNiwzLjgwOS0xMS4xMzksOS40MjQtMTEuMTM5LDE2Ljg0NyAgICBjMCw0Ljk0OCwxLjgxMSw5LjIzNiw1LjQyNCwxMi44NDdjMy42MTcsMy42MjEsNy45OTEsNS40MzIsMTMuMTMxLDUuNDMyYzIuMjg2LDAsNC42NjgtMC40ODMsNy4xMzktMS40MjggICAgQzM0MC4xMjgsMzYwLjc4MywzNjEuNTUxLDM0Mi44NDQsMzc3LjcyOCwzMTguMTk0eiIgZmlsbD0iIzkzM0VDNSIvPgoJCTxwYXRoIGQ9Ik00MzguODI0LDExNi45MmMtMjQuMTcxLTM2LjYzOC01Ni4zNDMtNjMuNjIyLTk2LjUwNS04MC45NDNjLTIuNDcxLTAuOTUtNC45NDgtMS40MjUtNy40MTYtMS40MjUgICAgYy00Ljk0OCwwLTkuMjM2LDEuODExLTEyLjg0Nyw1LjQyNGMtMy42MjEsMy42MTUtNS40MzIsNy45MDItNS40MzIsMTIuODVjMCw2Ljg1MSwzLjcxNCwxMi40NjksMTEuMTQsMTYuODQ2ICAgIGMxLjMzNSwwLjc1NiwzLjQ2NywxLjc1NSw2LjQyLDIuOTk2YzIuOTUsMS4yMzIsNS4wODksMi4yMzEsNi40MjcsMi45OTNjOC43NTQsNC43NTUsMTYuNTYsOS42MTEsMjMuNDE4LDE0LjU2ICAgIGMyMy40MDcsMTcuMzE4LDQxLjY4MiwzOC45MjIsNTQuODE2LDY0LjgwOWMxMy4xMzQsMjUuODg1LDE5LjY5Nyw1My4zODgsMTkuNjk3LDgyLjUxMmMwLDI5LjEyOS02LjU2Myw1Ni42MjYtMTkuNjk3LDgyLjUxMiAgICBjLTEzLjEzMSwyNS44ODktMzEuNDA5LDQ3LjQ5Ni01NC44MTYsNjQuODA5Yy02Ljg1OCw0Ljk0OC0xNC42NjQsOS44MDEtMjMuNDE4LDE0LjU2MmMtMS4zMzgsMC43NTYtMy40NzcsMS43NTItNi40MjcsMi45OSAgICBjLTIuOTUzLDEuMjMyLTUuMDg1LDIuMjMxLTYuNDIsMi45OThjLTcuNDI2LDQuMzc0LTExLjE0LDkuOTkzLTExLjE0LDE2Ljg0NGMwLDQuOTQ5LDEuODExLDkuMjMzLDUuNDMyLDEyLjg0OCAgICBjMy42MSwzLjYxNyw3Ljg5OCw1LjQyNywxMi44NDcsNS40MjdjMi40NjgsMCw0Ljk0NS0wLjQ3Niw3LjQxNi0xLjQzMWM0MC4xNjItMTcuMzE1LDcyLjMzNC00NC4zLDk2LjUwNS04MC45NCAgICBjMjQuMTc0LTM2LjYzOCwzNi4yNTgtNzYuODQ5LDM2LjI1OC0xMjAuNjI1UzQ2My4wMDEsMTUzLjU1NCw0MzguODI0LDExNi45MnoiIGZpbGw9IiM5MzNFQzUiLz4KCTwvZz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8L3N2Zz4K);
  /* background-position: center center !important; */
}

.btn-speaker:hover,
.btn-speaking {
  background-image: url(data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4PSIwcHgiIHk9IjBweCIgdmlld0JveD0iMCAwIDU4IDU4IiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCA1OCA1ODsiIHhtbDpzcGFjZT0icHJlc2VydmUiIHdpZHRoPSI1MTJweCIgaGVpZ2h0PSI1MTJweCI+CjxjaXJjbGUgc3R5bGU9ImZpbGw6I0Q3NUE0QTsiIGN4PSIyOSIgY3k9IjI5IiByPSIyOSIvPgo8cGF0aCBzdHlsZT0iZmlsbDojRkZGRkZGOyIgZD0iTTIyLjQyNywyMGgtOC4zMjNDMTIuOTQyLDIwLDEyLDIwLjk0MiwxMiwyMi4xMDR2MTIuNzkzQzEyLDM2LjA1OCwxMi45NDIsMzcsMTQuMTA0LDM3aDguMzIzICBjMC4zNzUsMCwwLjc0MywwLjEsMS4wNjcsMC4yOUwzNi44Myw0OS43MDZDMzguMjMyLDUwLjUzMSw0MCw0OS41Miw0MCw0Ny44OTNWOS4xMDdjMC0xLjYyNy0xLjc2OC0yLjYzOC0zLjE3LTEuODEzTDIzLjQ5NCwxOS43MSAgQzIzLjE3LDE5LjksMjIuODAyLDIwLDIyLjQyNywyMHoiLz4KPHBhdGggc3R5bGU9ImZpbGw6IzQyNEE2MDsiIGQ9Ik01MC44NjYsOS45NjJjLTAuNDM2LTAuNS0wLjg4NC0wLjk5Mi0xLjM2LTEuNDY4cy0wLjk2OC0wLjkyNC0xLjQ2OC0xLjM2TDcuMTM0LDQ4LjAzOCAgYzAuNDM2LDAuNSwwLjg4NCwwLjk5MiwxLjM2LDEuNDY4czAuOTY4LDAuOTI0LDEuNDY4LDEuMzZMNTAuODY2LDkuOTYyeiIvPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8L3N2Zz4K);
}

.btn-speaking:hover,
.btn-mute {
  background-image: url(data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4PSIwcHgiIHk9IjBweCIgdmlld0JveD0iMCAwIDU4IDU4IiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCA1OCA1ODsiIHhtbDpzcGFjZT0icHJlc2VydmUiIHdpZHRoPSI1MTJweCIgaGVpZ2h0PSI1MTJweCI+CjxjaXJjbGUgc3R5bGU9ImZpbGw6IzM4NDU0RjsiIGN4PSIyOSIgY3k9IjI5IiByPSIyOSIvPgo8cGF0aCBzdHlsZT0iZmlsbDojNzM4M0JGOyIgZD0iTTE2LjQyNywyMEg4LjEwNEM2Ljk0MiwyMCw2LDIwLjk0Miw2LDIyLjEwNHYxMi43OTNDNiwzNi4wNTgsNi45NDIsMzcsOC4xMDQsMzdoOC4zMjMgIGMwLjM3NSwwLDAuNzQzLDAuMSwxLjA2NywwLjI5TDMwLjgzLDQ5LjcwNkMzMi4yMzIsNTAuNTMxLDM0LDQ5LjUyLDM0LDQ3Ljg5M1Y5LjEwN2MwLTEuNjI3LTEuNzY4LTIuNjM4LTMuMTctMS44MTNMMTcuNDk0LDE5LjcxICBDMTcuMTcsMTkuOSwxNi44MDIsMjAsMTYuNDI3LDIweiIvPgo8cGF0aCBzdHlsZT0iZmlsbDojRUZDRTRBOyIgZD0iTTQxLjU0MSw0Mi4wNDJjLTAuMjU2LDAtMC41MTItMC4wOTgtMC43MDctMC4yOTNjLTAuMzkxLTAuMzkxLTAuMzkxLTEuMDIzLDAtMS40MTQgIGM2LjIzOC02LjIzOCw2LjIzOC0xNi4zOSwwLTIyLjYyOGMtMC4zOTEtMC4zOTEtMC4zOTEtMS4wMjMsMC0xLjQxNHMxLjAyMy0wLjM5MSwxLjQxNCwwYzcuMDE4LDcuMDE5LDcuMDE4LDE4LjQzOCwwLDI1LjQ1NiAgQzQyLjA1Miw0MS45NDQsNDEuNzk2LDQyLjA0Miw0MS41NDEsNDIuMDQyeiIvPgo8cGF0aCBzdHlsZT0iZmlsbDojRUZDRTRBOyIgZD0iTTM4LDM4Yy0wLjI1NiwwLTAuNTEyLTAuMDk4LTAuNzA3LTAuMjkzYy0wLjM5MS0wLjM5MS0wLjM5MS0xLjAyMywwLTEuNDE0ICBjNC4yOTctNC4yOTcsNC4yOTctMTEuMjg5LDAtMTUuNTg2Yy0wLjM5MS0wLjM5MS0wLjM5MS0xLjAyMywwLTEuNDE0czEuMDIzLTAuMzkxLDEuNDE0LDBjNS4wNzcsNS4wNzcsNS4wNzcsMTMuMzM3LDAsMTguNDE0ICBDMzguNTEyLDM3LjkwMiwzOC4yNTYsMzgsMzgsMzh6Ii8+CjxwYXRoIHN0eWxlPSJmaWxsOiNFRkNFNEE7IiBkPSJNNDQuNDc2LDQ3Yy0wLjI1NiwwLTAuNTEyLTAuMDk4LTAuNzA3LTAuMjkzYy0wLjM5MS0wLjM5MS0wLjM5MS0xLjAyMywwLTEuNDE0ICBjNC4zNTYtNC4zNTUsNi43NTUtMTAuMTQyLDYuNzU1LTE2LjI5M3MtMi4zOTktMTEuOTM4LTYuNzU1LTE2LjI5M2MtMC4zOTEtMC4zOTEtMC4zOTEtMS4wMjMsMC0xLjQxNHMxLjAyMy0wLjM5MSwxLjQxNCwwICBjNC43MzQsNC43MzMsNy4zNDEsMTEuMDIxLDcuMzQxLDE3LjcwN3MtMi42MDcsMTIuOTc0LTcuMzQxLDE3LjcwN0M0NC45ODgsNDYuOTAyLDQ0LjczMiw0Nyw0NC40NzYsNDd6Ii8+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+Cjwvc3ZnPgo=);
}
</style>
