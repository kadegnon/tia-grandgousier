<template>

</template>

<script>

export default {
  name: 'SwitchButton',
  props: {
    switch: false,
    labels: {
      type: Object,
      default: {
        checked : 'OFF',
        unchecked : 'ON'
      }
    },
  },
  computed: {},

  data () {
    return {

    }
  },
  methods: {

  }
}
</script>

<style lang="scss" scoped>

</style>
