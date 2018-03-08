<template>
  <div class="s2t">
    <div
        :class="{'btn-micro':!isRecording, 'btn-done':isRecording }"
        @click="start">
    </div>
  </div>

</template>

<script>

window.SpeechRecognition = (window.SpeechRecognition || window.webkitSpeechRecognition || window.mozSpeechRecognition);

export default {
  name: "speech2Text",
  props : ['lang'],
  data() {
    return {
      speech2Text : null,
      isRecording : false,
      results : [],
      text : ''
    };
  },
  mounted () {
    this.initRecognition();
  },
  methods: {
    initRecognition(){
      this.speech2Text = new window.SpeechRecognition();
      this.speech2Text.lang = 'fr-FR';
      this.speech2Text.interimResults = true;
      // this.speech2Text.maxAlternatives = 2;

      // this.speech2Text.onresult = ({results}) => {
      //   console.log(results);
      //   this.text = Array.from(results)
      //     .map(res => res[0])
      //     .map(res => res.transcript)
      //     .join(' ');
      // };

      this.speech2Text.onresult = ({results}) => {
        this.text = results[0][0].transcript;
        console.log('You said : ', this.text);
      }


      this.speech2Text.addEventListener('end', _ => {
        if (this.text !== '') {
          this.results.push(this.text);
          this.$emit('speech2Text-result', {
            results : this.results,
            lastSentence: this.text
          })
        }
        this.text = '';
        this.speech2Text.start()
      })
    },

    start(){
      this.speech2Text.start();
    },
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.s2t {
  position: absolute;
  height: 24px;
  width: 24px;
  top: 4px;
  right: 4px;
  z-index: auto;
}

.s2t .btn-micro {
  cursor: pointer;
  height: 100%;
  width: 100%;
  background-image: url(data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTguMS4xLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4PSIwcHgiIHk9IjBweCIgdmlld0JveD0iMCAwIDI4Ni4zNzQgMjg2LjM3NCIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgMjg2LjM3NCAyODYuMzc0OyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSIgd2lkdGg9IjY0cHgiIGhlaWdodD0iNjRweCI+CjxnIGlkPSJNaWNyb19feDJGX19SZWNvcmRpbmciPgoJPHBhdGggc3R5bGU9ImZpbGwtcnVsZTpldmVub2RkO2NsaXAtcnVsZTpldmVub2RkOyIgZD0iTTE0My4xODcsMTg3LjkzM2MzMi4xMjYsMCw1OC4xNy0yNi4wNDMsNTguMTctNTguMTdWNTguMTcgICBjMC0zMi4xMjYtMjYuMDQ0LTU4LjE3LTU4LjE3LTU4LjE3Yy0zMi4xMjYsMC01OC4xNywyNi4wNDMtNTguMTcsNTguMTd2NzEuNTk0Qzg1LjAxNywxNjEuODksMTExLjA2MSwxODcuOTMzLDE0My4xODcsMTg3LjkzM3ogICAgTTI0Ni4xMDMsMTAyLjkxNmMwLTcuNDE0LTYuMDExLTEzLjQyNC0xMy40MjQtMTMuNDI0Yy03LjQxNCwwLTEzLjQyNCw2LjAxLTEzLjQyNCwxMy40MjRjMCwwLjYxMiwwLjEwMSwxLjE5NiwwLjE4LDEuNzg3ICAgYy0wLjExNSwwLjg1LTAuMTgsMS43NDItMC4xOCwyLjY4OHYyNi44NDhjMCwzOS40NzQtMzMuNTc2LDcxLjU0LTc0Ljc4OCw3MS41NGMtNDEuMjE0LDAtNzcuMzQ4LTMyLjA2Ni03Ny4zNDgtNzEuNTRWMTA3LjM5ICAgYzAtMC43NTctMC4xMTQtMS40NDctMC4yMzctMi4xM2MwLjEzNS0wLjc2NCwwLjIzNy0xLjU0MSwwLjIzNy0yLjM0NGMwLTcuNDE0LTYuMDEtMTMuNDI0LTEzLjQyNC0xMy40MjQgICBjLTcuNDE0LDAtMTMuNDI0LDYuMDEtMTMuNDI0LDEzLjQyNGMwLDAuODAzLDAuMTAxLDEuNTgsMC4yMzcsMi4zNDRjLTAuMTIzLDAuNjgzLTAuMjM3LDEuMzczLTAuMjM3LDIuMTNsLTAuMDAxLDMwLjQyNyAgIGMwLDUwLjM4MiwzOS43MDEsODcuODcsODkuNDkyLDk0Ljg2MnYyNi44NDhIODUuMDE3Yy0wLjc5NywwLTEuNTE5LDAuMTE0LTIuMjQyLDAuMjI1Yy0wLjczLTAuMTIzLTEuNDY4LTAuMjI1LTIuMjMzLTAuMjI1ICAgYy03LjQxNCwwLTEzLjQyNCw2LjAxLTEzLjQyNCwxMy40MjRjMCw3LjQxNCw2LjAxLDEzLjQyNCwxMy40MjQsMTMuNDI0YzAuNzY1LDAsMS41MDMtMC4xMDIsMi4yMzMtMC4yMjUgICBjMC43MjMsMC4xMTEsMS40NDUsMC4yMjUsMi4yNDIsMC4yMjVoMTE2LjM0YzAuNzk3LDAsMS41MTktMC4xMTQsMi4yNDEtMC4yMjVjMC43MywwLjEyMywxLjQ2OCwwLjIyNSwyLjIzMywwLjIyNSAgIGM3LjQxNCwwLDEzLjQyNC02LjAxLDEzLjQyNC0xMy40MjRjMC03LjQxNC02LjAwOS0xMy40MjQtMTMuNDI0LTEzLjQyNGMtMC43NjUsMC0xLjUwMywwLjEwMi0yLjIzMywwLjIyNSAgIGMtMC43MjMtMC4xMTEtMS40NDQtMC4yMjUtMi4yNDEtMC4yMjVoLTQ0Ljc0N3YtMjYuODQ4YzQ5Ljc5Mi02Ljk5Miw4OS40OTItNDQuNDgsODkuNDkyLTk0Ljg2MmwwLjAwMS0zMC40MjcgICBjMC0wLjc2Ny0wLjExMy0xLjQ3Ni0wLjIzMi0yLjE3OUMyNDYuMDAyLDEwNC40NjIsMjQ2LjEwMywxMDMuNzAyLDI0Ni4xMDMsMTAyLjkxNnoiIGZpbGw9IiMwMDZERjAiLz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8L3N2Zz4K);
  background-size: 100%;
  background-repeat: no-repeat !important;
  background-position: center center !important;
  margin: 0px !important;
  padding: 0px !important;
}

/* .s2t:hover,.s2t:active{ */
  /* border-radius: 45%; */
  /* box-shadow: 2px 5px 6px crimson; */
  /* border: 1px solid; */
/* } */
</style>
