<template>
  <div class="chat">
    <h1>{{ msg }}</h1>
    <h2>Essential Links</h2>
    <ul v-model:"m in messages"> 
      <chat-msg :msg="m.content" :type="m.type"> </chat-msg>
    </ul>
    <user-choice>

    </user-choice>
  </div>
</template>

<script>
export default {
  data() {
    return {
    };
  },
};
</script>


<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .chat {
    max-width: 640px;
    margin: 0 auto
  }

  .chat ul {
    padding: 20px 50px
  }
</style>
