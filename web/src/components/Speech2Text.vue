<template>
  <div class="s2t">
    <div v-if="!isRecording"
        class="btn-micro"
        title="Dicter phrase "
        @click="start">
    </div>
    <div v-else
        class="btn-done"
        title="Arreter l'enregistrement"
        @click="stop">
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
      text : ''
    };
  },
  mounted () {
    this.initRecognition();
  },
  methods: {
    initRecognition(){
      this.speech2Text = new window.SpeechRecognition();
      this.speech2Text.lang = this.lang;
      this.speech2Text.interimResults = false;

      // this.speech2Text.onresult = ({results}) => {
      //   console.log(results);
      //   this.text = Array.from(results)
      //     .map(res => res[0])
      //     .map(res => res.transcript)
      //     .join(' ');
      // };

      this.speech2Text.onresult = ({results}) => {
        this.text = results[0][0].transcript;
        // console.log('You said : ', this.text);
      }


      this.speech2Text.addEventListener('end', _ => {
        if (this.text !== '') {
          // this.results.push(this.text);
          this.$emit('s2t-text', this.text + ' ');
        }
        this.text = '';
        if(this.isRecording){
          this.speech2Text.start();
        }
      })
    },

    start(){
      this.speech2Text.start();
      this.isRecording = true;
    },


    stop(){
      this.speech2Text.stop();
      this.isRecording = false;
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
  background-image: url(data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTYuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4PSIwcHgiIHk9IjBweCIgd2lkdGg9IjMycHgiIGhlaWdodD0iMzJweCIgdmlld0JveD0iMCAwIDQ2NS4yNTYgNDY1LjI1NiIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNDY1LjI1NiA0NjUuMjU2OyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+CjxnPgoJPGc+CgkJPHBhdGggZD0iTTg3Ljc0MiwyMDQuODc5Yy04LjY2OCwwLTE1LjcwMSw3LjAzNS0xNS43MDEsMTUuNzAxYzAsODMuMjUyLDYzLjY4LDE1MS44ODMsMTQ0Ljg4NiwxNTkuODAydjUzLjQ3MWgtODYuOTEzICAgIGMtOC42NjYsMC0xNS43MDEsNy4wMzMtMTUuNzAxLDE1LjcwMWMwLDguNjY0LDcuMDM1LDE1LjcwMSwxNS43MDEsMTUuNzAxaDEwMi42MTRoMTAyLjYxN2M4LjY1OSwwLDE1LjcwMS03LjAzNywxNS43MDEtMTUuNzAxICAgIGMwLTguNjY4LTcuMDQyLTE1LjcwMS0xNS43MDEtMTUuNzAxaC04Ni45MTh2LTUzLjQ3MWM4MS4yMTEtNy45MTksMTQ0Ljg4OS03Ni41NSwxNDQuODg5LTE1OS44MDIgICAgYzAtOC42NjYtNy4wMjktMTUuNzAxLTE1LjcwMS0xNS43MDFjLTguNjY0LDAtMTUuNzAxLDcuMDM1LTE1LjcwMSwxNS43MDFjMCw3MS4yMy01Ny45NTUsMTI5LjE4OS0xMjkuMTg1LDEyOS4xODkgICAgYy03MS4yMzYsMC0xMjkuMTg1LTU3Ljk1OS0xMjkuMTg1LTEyOS4xODlDMTAzLjQ0MywyMTEuOTE1LDk2LjQxNiwyMDQuODc5LDg3Ljc0MiwyMDQuODc5eiIgZmlsbD0iIzAwMDAwMCIvPgoJCTxwYXRoIGQ9Ik0yMjIuMDE0LDMyNi4wOThoMjIuNjI2YzQ2LjAxNCwwLDgzLjMxMS0zNy4yOTcsODMuMzExLTgzLjMwNkgxMzguNzA0QzEzOC43MDQsMjg4LjgwMSwxNzYuMDAxLDMyNi4wOTgsMjIyLjAxNCwzMjYuMDk4eiAgICAiIGZpbGw9IiMwMDAwMDAiLz4KCQk8cGF0aCBkPSJNMjQ1LjEyNSwwaC0yMi42MzJjLTQ2LjAxMywwLTgzLjMxLDM3LjI5Ny04My4zMSw4My4zMWgxODkuMjUzQzMyOC40MzYsMzcuMjk3LDI5MS4xMywwLDI0NS4xMjUsMHoiIGZpbGw9IiMwMDAwMDAiLz4KCQk8cmVjdCB4PSIxMzkuMTgzIiB5PSI5OS44NTEiIHdpZHRoPSIxODguMjg2IiBoZWlnaHQ9IjMxLjQiIGZpbGw9IiMwMDAwMDAiLz4KCQk8cmVjdCB4PSIxMzkuODY0IiB5PSIxNDYuNjYyIiB3aWR0aD0iMTg4LjI4NyIgaGVpZ2h0PSIzMS40IiBmaWxsPSIjMDAwMDAwIi8+CgkJPHJlY3QgeD0iMTM4LjQ4NSIgeT0iMTk1LjA2NyIgd2lkdGg9IjE4OC4yNzkiIGhlaWdodD0iMzEuNCIgZmlsbD0iIzAwMDAwMCIvPgoJPC9nPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+Cjwvc3ZnPgo);
  background-size: 100%;
  background-repeat: no-repeat !important;
  background-position: center center !important;
  margin: 0px !important;
  padding: 0px !important;
}

.s2t .btn-done {
  cursor: pointer;
  height: 100%;
  width: 100%;
  background-image: url(data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4PSIwcHgiIHk9IjBweCIgdmlld0JveD0iMCAwIDU4IDU4IiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCA1OCA1ODsiIHhtbDpzcGFjZT0icHJlc2VydmUiIHdpZHRoPSI1MTJweCIgaGVpZ2h0PSI1MTJweCI+CjxjaXJjbGUgc3R5bGU9ImZpbGw6I0Q3NUE0QTsiIGN4PSIyOSIgY3k9IjI5IiByPSIyOSIvPgo8Zz4KCTxyZWN0IHg9IjE2IiB5PSIxNiIgc3R5bGU9ImZpbGw6I0ZGRkZGRjsiIHdpZHRoPSIyNiIgaGVpZ2h0PSIyNiIvPgoJPHBhdGggc3R5bGU9ImZpbGw6I0ZGRkZGRjsiIGQ9Ik00Myw0M0gxNVYxNWgyOFY0M3ogTTE3LDQxaDI0VjE3SDE3VjQxeiIvPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+Cjwvc3ZnPgo=);
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
