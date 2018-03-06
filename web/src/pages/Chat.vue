<template>
  <section class="chat">
    <h1>Chat Page</h1>
    <h2>Essential Links</h2>
    <ul>
      <chat-msg :msg="m.content" :type="m.type"> </chat-msg>
      <user-choice></user-choice>
    </ul>

    <textarea name="chat-input-msg" id="chat-input-msg" cols="30" rows="10"
      placeholder="Enter votre message !"
      v-model.lazy.trim="chatInputMsg"
    ></textarea>


  </section>
</template>

<script>
export default {
  data : {
    chatInputMsg : ''
  },
};
</script>


<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .xchat {
    max-width: 640px;
    margin: 0 auto
  }

  .xchat ul {
    padding: 20px 50px
  }
</style>
