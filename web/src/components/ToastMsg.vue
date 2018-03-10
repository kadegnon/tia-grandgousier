<template>
  <div id="toast-msg" v-bind:class="[type]" v-show="visible">
    <span class="btn-close" @click="close">&times;</span>
    <span>{{msg}}</span>
  </div>

</template>

<script>
import Vue from "vue";

export default {
  name: "ToastMsg",
  data() {
    return {
      msg: "Yello, mon p*t**n de message ! ",
      type: "info",
      visible: false,
      autoCloseTimeoutID: 0
    };
  },
  watch: {
    type: function() {
      this.visible = true;
    }
  },
  created() {
    this.$bus.$on('msg-info', msg => this.display(msg));
    this.$bus.$on('msg-warning', msg => this.display(msg,'warning'));
    this.$bus.$on('msg-error', msg => this.display(msg,'error'));
    this.$bus.$on('msg-success', msg => this.display(msg,'success'));
  },
  beforeDestroy() {
    this.$bus.$off(['msg-info', 'msg-warning', 'msg-error','msg-success']);
    console.log('Destroy comp. ',this.autoCloseTimeoutID);
    clearInterval(this.autoCloseTimeoutID);
  },
  methods: {
    initAutoClose(time = 4) {
      this.autoCloseTimeoutID = setTimeout(() => {
        console.log("Toast Autclosed in ", time);
        this.close();
      }, time * 1000);
    },

    close() {
      this.visible = false;
      clearInterval(this.autoCloseTimeoutID);
    },

    display(msg, type='info') {
      this.msg = msg;
      this.type = type;
      this.initAutoClose();
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
#toast-msg {
  min-width: 250px;
  margin-left: -125px;
  background-color: #333;
  color: #fff;
  text-align: center;
  border-radius: 2px;
  padding: 16px;
  position: fixed;
  z-index: 1;
  bottom: 30px;
  left: 50%;
}

#toast-msg.success {
  background-color: aquamarine;
  color: black;
}
#toast-msg.info {
  background-color: #2196f3;
}
#toast-msg.warning {
  background-color: #ff9800;
}
#toast-msg.error {
  background-color: crimson;
}

#toast-msg > .btn-close {
  margin-left: 15px;
  color: white;
  font-weight: bold;
  float: right;
  font-size: 22px;
  line-height: 20px;
  cursor: pointer;
  transition: 0.3s;
}

.btn-close:hover {
  color: black;
}
</style>
