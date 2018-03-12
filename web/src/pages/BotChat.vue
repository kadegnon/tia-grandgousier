<template>
  <section class="chat">
    <h1>Bot Chat</h1>
    <transition-group name="msg-list" tag="ul" ref="msgList">
      <chat-msg
        v-for="msg in msgs"
        v-bind:key="msg.time"
        :msg="msg"
        class="msg"
      />
    </transition-group>

    <user-choice v-if="hasChoices" :choice="choice"  @select-response="userChoiceResponse" />

    <div class="chat-msg">
      <textarea name="chat-msg-input" class="chat-msg-input" cols="50" rows="5"
        placeholder="Entrer ou dicter votre requête !"
        v-bind:maxlength="maxLimit"
        v-model.trim="chatInputMsg"
        @keyup.enter="sendMsg"
      > </textarea>

      <s2t @s2t-text="handleS2Text"
          :user-commands="commands"  @s2t-command="handleS2Cmd"
          @s2t-permission="allowMicro"/>
    </div>

    <span id='chat-msg-input-limit'>{{limitChatInputMsg}}</span>


  </section>
</template>

<script>
import ChatMsg from "@/components/ChatMsg.vue";
import UserChoice from "@/components/UserChoice.vue";
import Speech2Text from "@/components/Speech2Text.vue";

const {msgs:defMsgs} = require('@/mocks/chat-msg-intro.json');

const createMsg = (msg, type) => {
  return {
    time: Date.now(),
    type,
    content:msg
  };
};

const wait = (t=100) => {
  const d = new Date();
  let d2 = null;
  do {
    d2 = new Date();
  } while (d2 - d < t);
};

export default {
  components: {
    ChatMsg,
    UserChoice,
    s2t: Speech2Text
  },
  data() {
    return {
      maxLimit: 150,
      isLoading: true,
      msgs: defMsgs,
      isUserTyping: false,
      chatInputMsg: "",
      hasChoices: false,
      choice: {},
      commands : [
        'efface',
        'envoye',
        'envoie',
        'ok',
        'okay',
        'point'
      ]
    };
  },
  updated() {
    const elt = this.$refs.msgList.$el;
    this.$refs.msgList.scrollTop = elt.scrollHeight;
  },
  computed: {
    limitChatInputMsg() {
      return this.chatInputMsg.length + "/" + this.maxLimit;
    }
  },
  methods: {
    allowMicro(perm) {
      this.$bus.$emit('msg-warning', 'Veuillez autoriser l\'utilisation du micro');
    },
    handleS2Cmd(cmd){
      console.log('Cmd : ', cmd);
      switch (cmd) {
        case 'efface':
          this.chatInputMsg = '';
          break;
        case 'envoye':
        case 'envoie':
        case 'ok':
        case 'okay':
          this.sendMsg();
          break;

        case 'point' :
        case 'à la ligne' :
          this.chatInputMsg += '. ';
        break;
          // this.chatInputMsg += '.\n';

        default:
          break;
      }
    },

    handleS2Text(text){
      console.log('Moi : ', text);
      this.chatInputMsg += text;
    },

    userChoiceResponse(response) {
      this.hasChoices = false;
      console.log(response);
    },
    sendMsg() {
      const msg = createMsg(this.chatInputMsg, "user");
      this.msgs.push(msg);
      this.$http
        .post("bot/", { demande: this.chatInputMsg })
        .then(res => this.handleBotResponse(res.data));
      this.chatInputMsg = "";
    },

    handleBotResponse(response) {
      if (Array.isArray(response)) {
        response.forEach(res => {
          const msg = createMsg(res, "bot");
          this.msgs.push(msg);
          wait();
        });
      } else {
        this.msgs.push(createMsg(response, "bot"));
      }
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
/*.chat {
  max-width: 650px;
  margin: 0 auto;
}*/

.msg-loading {
  text-align: left;
  margin-left: 40px;
}
.chat ul {
  padding: 10px 40px;
    max-height: 500px;
    overflow: auto;
}


.chat-msg {
  position: relative;
}
.chat-msg .chat-msg-input {
  width: 100%;
  height: 100%;
  box-sizing: border-box;

  transition: all 0.3s ease-in-out;
}
.chat-msg .btn-mic {
  position: absolute;
  /* height: 100%; */
  /* width: 100%; */
  top: 0;
  right: 0;
  background-image: url(data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTguMS4xLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4PSIwcHgiIHk9IjBweCIgdmlld0JveD0iMCAwIDI4Ni4zNzQgMjg2LjM3NCIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgMjg2LjM3NCAyODYuMzc0OyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSIgd2lkdGg9IjY0cHgiIGhlaWdodD0iNjRweCI+CjxnIGlkPSJNaWNyb19feDJGX19SZWNvcmRpbmciPgoJPHBhdGggc3R5bGU9ImZpbGwtcnVsZTpldmVub2RkO2NsaXAtcnVsZTpldmVub2RkOyIgZD0iTTE0My4xODcsMTg3LjkzM2MzMi4xMjYsMCw1OC4xNy0yNi4wNDMsNTguMTctNTguMTdWNTguMTcgICBjMC0zMi4xMjYtMjYuMDQ0LTU4LjE3LTU4LjE3LTU4LjE3Yy0zMi4xMjYsMC01OC4xNywyNi4wNDMtNTguMTcsNTguMTd2NzEuNTk0Qzg1LjAxNywxNjEuODksMTExLjA2MSwxODcuOTMzLDE0My4xODcsMTg3LjkzM3ogICAgTTI0Ni4xMDMsMTAyLjkxNmMwLTcuNDE0LTYuMDExLTEzLjQyNC0xMy40MjQtMTMuNDI0Yy03LjQxNCwwLTEzLjQyNCw2LjAxLTEzLjQyNCwxMy40MjRjMCwwLjYxMiwwLjEwMSwxLjE5NiwwLjE4LDEuNzg3ICAgYy0wLjExNSwwLjg1LTAuMTgsMS43NDItMC4xOCwyLjY4OHYyNi44NDhjMCwzOS40NzQtMzMuNTc2LDcxLjU0LTc0Ljc4OCw3MS41NGMtNDEuMjE0LDAtNzcuMzQ4LTMyLjA2Ni03Ny4zNDgtNzEuNTRWMTA3LjM5ICAgYzAtMC43NTctMC4xMTQtMS40NDctMC4yMzctMi4xM2MwLjEzNS0wLjc2NCwwLjIzNy0xLjU0MSwwLjIzNy0yLjM0NGMwLTcuNDE0LTYuMDEtMTMuNDI0LTEzLjQyNC0xMy40MjQgICBjLTcuNDE0LDAtMTMuNDI0LDYuMDEtMTMuNDI0LDEzLjQyNGMwLDAuODAzLDAuMTAxLDEuNTgsMC4yMzcsMi4zNDRjLTAuMTIzLDAuNjgzLTAuMjM3LDEuMzczLTAuMjM3LDIuMTNsLTAuMDAxLDMwLjQyNyAgIGMwLDUwLjM4MiwzOS43MDEsODcuODcsODkuNDkyLDk0Ljg2MnYyNi44NDhIODUuMDE3Yy0wLjc5NywwLTEuNTE5LDAuMTE0LTIuMjQyLDAuMjI1Yy0wLjczLTAuMTIzLTEuNDY4LTAuMjI1LTIuMjMzLTAuMjI1ICAgYy03LjQxNCwwLTEzLjQyNCw2LjAxLTEzLjQyNCwxMy40MjRjMCw3LjQxNCw2LjAxLDEzLjQyNCwxMy40MjQsMTMuNDI0YzAuNzY1LDAsMS41MDMtMC4xMDIsMi4yMzMtMC4yMjUgICBjMC43MjMsMC4xMTEsMS40NDUsMC4yMjUsMi4yNDIsMC4yMjVoMTE2LjM0YzAuNzk3LDAsMS41MTktMC4xMTQsMi4yNDEtMC4yMjVjMC43MywwLjEyMywxLjQ2OCwwLjIyNSwyLjIzMywwLjIyNSAgIGM3LjQxNCwwLDEzLjQyNC02LjAxLDEzLjQyNC0xMy40MjRjMC03LjQxNC02LjAwOS0xMy40MjQtMTMuNDI0LTEzLjQyNGMtMC43NjUsMC0xLjUwMywwLjEwMi0yLjIzMywwLjIyNSAgIGMtMC43MjMtMC4xMTEtMS40NDQtMC4yMjUtMi4yNDEtMC4yMjVoLTQ0Ljc0N3YtMjYuODQ4YzQ5Ljc5Mi02Ljk5Miw4OS40OTItNDQuNDgsODkuNDkyLTk0Ljg2MmwwLjAwMS0zMC40MjcgICBjMC0wLjc2Ny0wLjExMy0xLjQ3Ni0wLjIzMi0yLjE3OUMyNDYuMDAyLDEwNC40NjIsMjQ2LjEwMywxMDMuNzAyLDI0Ni4xMDMsMTAyLjkxNnoiIGZpbGw9IiMwMDZERjAiLz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8L3N2Zz4K);
  background-size: 100%;
  background-repeat: no-repeat !important;
  background-position: center center !important;
  margin: 0px !important;
  padding: 0px !important;


}


.chat-msg .chat-msg-input:active,
.chat-msg .chat-msg-input:focus {
  border-radius: 0.5rem;
  border: 1px solid blanchedalmond;
  box-shadow: 2px 2px 0px 1px blanchedalmond;
}

#chat-msg-input-limit {
  float: right;
}

.msg {
  transition: all 0.3s ease-in-out;
  /* transition: all 500ms; */
}
.msg-list-enter,
.msg-list-enter-active {
  opacity: 0 0.5s;
}

.msg-list-leave-active {
  opacity: 0;
}

/* .msg-list-enter .msg-list-container,
.msg-list-leave-active .msg-list-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
} */

/* .fade-enter-active, .fade-leave-active {
  transition: opacity .5s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
} */
</style>
