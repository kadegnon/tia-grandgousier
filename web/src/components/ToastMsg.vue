<template>
  <div id="toast-msg" v-bind:class="[type]" v-show="visible">
    <span class="btn-close" @click="">&times;</span>
    <span>{{msg}}</span>
  </div>

</template>

<script>
export default {
  name: "ToastMsg",
  data() {
    return {
      msg : 'Yello, mon p*t**n de message ! ',
      type : 'info',
      visible : false,
    };
  },
  mounted (){
    this.$on('msg-error',msg => {
        this.msg = msg;
        this.type = 'error';
        this.initAutoClose();
    });

    this.$on('msg-info',msg => {
        this.msg = msg;
        this.type = 'info'
        this.initAutoClose();
    });

    this.$on('msg-success',msg => {
        this.msg = msg;
        this.type = 'success'
      this.initAutoClose();
    });
  },
  methods : {
    initAutoClose(time=4){
        setTimeout(() => {
          console.log('Autclosing in ',time);
          this.close();
        },time*1000);
    },

    close(){
      this.visible = false;
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

  #toast-msg.success {background-color: aquamarine; color:black}
  #toast-msg.info {background-color: #2196F3;}
  #toast-msg.warning {background-color: #ff9800;}
  #toast-msg.error {background-color: crimson;}

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
