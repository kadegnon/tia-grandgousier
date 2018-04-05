<template>
  <div class="user-choice">
    <p class="question">{{choice.question}}</p>
    <a class="response"
      v-bind:key="index"
      v-for="(resp,index) in choice.responses"
      @click.stop.prevent="selectResponse(resp)"
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
  display: block;
  margin-right: 40px;
  text-align: right;

}

.user-choice>.question {
  color: #db0bc9;
  display: block;
  font-weight: bold;
  /* -webkit-margin-before: 1.33em;
  -webkit-margin-after: 1.33em;
  -webkit-margin-start: 0px;
  -webkit-margin-end: 0px; */
}


.user-choice>.response {
  color: chocolate;
  display: block;
  cursor: pointer;
  padding-block-end: 4px;
}
.user-choice>.response:hover{
  text-decoration: underline;
}

.user_choice-enter,
.user_choice-leave-to {
  opacity: 0;
  transform: translateY(30px);
}
</style>
