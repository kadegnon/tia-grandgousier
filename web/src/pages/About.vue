<template>
  <div class="about">
    <h2>Team</h2>


    <template v-for="(member,index) in group" class="row">

      <div class="column team-member">
        <img class="avatar"
             src="@/assets/img/abuelo.jpg"
             v-bind:alt="'Avatar of '+  member.username"
             v-bind:title="'Avatar of '+  member.username"
        >
        <div class="info">
          <h1>John Mocky</h1>
          <p class="description">Joven negro & Yellow</p>
          <div class="links">
            <a v-for="(url,name, i) in member.links"
               v-bind:href="url">
              <i class="['fa', 'fa-'+name]"></i>
            </a>
          </div>

        </div>
      </div>
    </template>

  </div>
</template>

<script>
  const {members} = require('@/assets/group.json');


export default {

  data() {
    return {
        group : members
    };
  },
};
</script>


<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .team-member {
    position: relative;
    float: left;
    width: 30%;
    margin-top: 6px;
    padding: 1.5%;
  }

  /* Create two columns that float next to eachother */
  .column {

  }

  /* Clear floats after the columns */
  .row:after {
    content: "";
    display: table;
    clear: both;
  }

  .avatar {
    opacity: 1;
    display: block;
    width:250px;
    height: auto;
    transition: .5s ease;
    backface-visibility: hidden;
  }

  .info {
    transition: .5s ease;
    opacity: 0;
    position: absolute;
    bottom :-50px;
    margin-left:150px;
    transform: translate(-50%, -50%);
    -ms-transform: translate(-50%, -50%);
    text-align: center;
    background-color: cadetblue;
    box-shadow: 0 5px 10px 5px gray;
    max-width: 500px;
    padding: 10px;
  }

  .team-member:hover .avatar {
    opacity: 0.3;
  }

  .team-member:hover .info {
    opacity: 1;
  }

  .text {
    color: white;
    font-size: 16px;
    padding: 16px 32px;
  }

  .info > .description {
    color: white;
    font-size: 18px;
  }



  .info > .links {
    text-decoration: none;
    font-size: 22px;
    color: black;
    margin: 24px 0;
  }


  /* Responsive layout - when the screen is less than 550px wide, make the two columns stack on top of each other instead of next to each other */
  @media (max-width: 550px) {
    .column{
      width: 50%;
      margin-left: 50px;
      margin-bottom: 100px;
    }
  }
  @media (max-width: 350px) {
    .column{
      width: 100%;
      margin-top: 0;
    }
  }
</style>
