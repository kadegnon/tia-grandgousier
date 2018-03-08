<template>
  <div class="user-choice">
    <h4>{{choice.question}}</h4>
    <a class="response"
      v-bind:key="index"
      v-for="(resp,index) in choice.responses"
      @click="selectResponse(resp)"
    >{{resp}}</a>
  </div>
</template>

<script>
export default {
  name: "userChoice",
  props : ['choice'],
  data() {
    return {

    };
  },
  computed : {

  },
  methods :{
    selectResponse(response){
      this.$emit('select-response', response);
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.user-choice {
  transition: all 1s;
}

.user_choice-list-enter,
.user_choice-list-leave-to {
  opacity: 0;
  transform: translateY(30px);
}

.user-choice-list {
  margin-right: 40px;
  display: block;
  text-align: right;
  color: #db0bc9;
}
</style>
