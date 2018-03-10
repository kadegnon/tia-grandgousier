<template>
  <!-- <article class="chat-msg"> -->
    <li :class="'msg-' + this.msg.type">
      <span>
        <i style="float:left;">x</i>&nbsp;
        {{this.msg.content.trim()}}

      </span>
    </li>
    <!-- </ul> -->
  <!-- </article> -->
</template>

<script>
export default {
  name: "chatMsg",
  props: ["msg"],
  data() {
    return {};
  },
  computed: {
    cssClass() {
      return "msg-" + this.msg.type;
    }
  },
  methods: {}
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.msg {
  list-style: none;
  margin-bottom: 5px;
}

.msg span {
  padding: 10px;
  display: inline-block;
  background:aquamarine;
  position: relative;
  border-radius: 0.5rem;
  max-width: 80%;
}

.msg-bot {
  text-align: left;
}

.msg-bot span:before {
  content: "";
  display: block;
  position: absolute;
  border: 8px solid transparent;
  border-right-color: aquamarine;
  left: -16px;
  bottom: 8px;
}

.msg-user {
  text-align: right;
}

.msg-user span {
  background: blanchedalmond;
}

.msg-user span:after {
  content: "";
  display: block;
  position: absolute;
  border: 8px solid transparent;
  border-left-color: bisque;
  right: -16px;
  bottom: 5px;
}

.msg-bot + .msg-user,
.msg-user + .msg-bot {
  margin-top: 10px;
}
</style>
