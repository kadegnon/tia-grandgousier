<template>
  <section class="chat">
    <h1>Bot Chat</h1>
    <transition-group name="msg-list" tag="ul">
      <chat-msg
        v-for="m in msgs"
        v-bind:key="m.time"
        :msg="m"
        class="msg"
      />
    </transition-group>
    <user-choice v-if="hasChoices" :choice="choice"  @select-response="userChoiceResponse"></user-choice>

    <textarea name="chat-msg-input" class="chat-msg-input" cols="50" rows="5"
      placeholder="Entrer votre message !"
      v-model.lazy.trim="chatInputMsg"
    ></textarea>


  </section>
</template>

<script>
import ChatMsg from "@/components/ChatMsg.vue";
import UserChoice from "@/components/UserChoice.vue";

export default {
  components: {
    ChatMsg,
    UserChoice,
  },
  data() {
    return {
      isLoading: true,
      msgs: [
        {
          time: 1520499515666,
          type: "bot",
          msg: "Bonjour, Je suis GrandGousier, un bot conseiller en vin."
        },
        {
          time: 1520499515676,
          type: "bot",
          msg: "Du Bordeaux Rouge au Champagnes Grand cru, je m'y connais !"
        },
        {
          time: 1520499759040,
          type: "bot",
          msg: "Puis-vous conseiller un bon vin ?"
        },
        { time: 1520499769993, type: "user", msg: "Okay, Je suis Pierrot, " },
        {
          time: 1520499787440,
          type: "bot",
          msg: "Cool, mucho encantado Pierrot !."
        },
        {
          time: 1520499790184,
          type: "bot",
          msg: "I'm the BEST bot in the World ! :-D"
        }
      ],
      isUserTyping: false,
      chatInputMsg: "",
      hasChoices: false,
      choice : {}
    };
  },
  methods : {
    userChoiceResponse(response){
      this.hasChoices = false;
      console.log(response);
    }
  }
};
</script>


<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.chat {
  max-width: 640px;
  margin: 0 auto;
}

.chat ul {
  padding: 10px 40px;
}
.msg-loading {
  text-align: left;
  margin-left: 40px;
}

.chat-msg-input {
  width: 100%;
  margin: 24px;
  padding: 12px;
  display: inline-block;
  box-sizing: border-box;
  resize: none;

  transition :all 0.30s ease-in-out;
  outline: none;
}

.chat-msg-input:active,
.chat-msg-input:focus{
  border-radius: 0.5rem;
  border: 1px solid blanchedalmond;
  box-shadow :2px 2px 0px 1px blanchedalmond;
}

.msg {
  transition :all 0.30s ease-in-out;
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
