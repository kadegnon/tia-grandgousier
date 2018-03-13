<template>
  <div id="app">
    <nav-links />

    <toast-msg />

    <text-2-speech standalone=true />


    <router-view />

  </div>
</template>

<script>
import NavLinks from "./components/NavLinks";
import ToastMsg from "./components/ToastMsg";
import Text2Speech from "@/components/Text2Speech.vue";

export default {
  name: "App",
  components: {
    NavLinks,
    ToastMsg,
    Text2Speech
  }
};
</script>

<style>
#app {
  font-family: "Palatino Linotype", "Book Antiqua", Palatino, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  max-width: 650px;
  margin: 0 auto;
  padding: 30px 0;
}

/* Create two columns that float next to eachother */
.column {
  float: left;
  width: 45%;
  margin: 2%;
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

.clearfix::after {
  content: "";
  clear: both;
  display: table;
}

.btn {
  border: none; /* Remove borders */
  color: white; /* Add a text color */
  padding: 14px 28px; /* Add some padding */
  cursor: pointer; /* Add a pointer cursor on mouse-over */
}

.success {background-color: mediumaquamarine;} /* Green */

.info {background-color: #2196F3;}
.info:hover {background: #0b7dda;}

.warning {background-color: #ff9800;}
.warning:hover {background: #e68a00;}

.danger {background-color: #f44336;}
.danger:hover {background: #da190b;}

.default {background-color: #e7e7e7; color: black;}
.default:hover {background: #ddd;}

/* Responsive layout - when the screen is less than 550px wide, make the two columns stack on top of each other instead of next to each other */
@media (max-width: 550px) {
  .column {
    width: 50%;
    margin-left: 50px;
    margin-bottom: 100px;
  }
}
@media (max-width: 350px) {
  .column {
    width: 100%;
    margin-top: 0;
  }
}
</style>
