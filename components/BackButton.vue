<template>
  <b-button
    variant="light"
    @click="$router.back()"
    class="back text-uppercase font-weight-bold align-items-center"
    :class="{'desktop-hide' : isMobile, 'mobile-hide' : isDesktop}"
  >
    <img
      src="~/static/icons/ic_chevron_right_48px.svg"
      alt="Retour page précédente"
    />
    Retour
  </b-button>
</template>

<script>
export default {
  name: "BackButton",
  props: {
    isMobile: Boolean,
    isDesktop: Boolean,
  }
}
</script>

<style lang="scss" scoped>
button {
  display: flex;
}

.desktop-hide {
  @media(min-width: 768px) {
    display: none;
  }
}

.mobile-hide {
  @media (max-width: 768px) {
    display: none;
  }
}

button,
a {
  font-size: 1.6rem;
  border-radius: 6px;
  padding: 6px 12px;
  color: black !important;

  &.new-offre {
    font-weight: bold;
  }

  &.back {
    img {
      transform: rotate(180deg);
      width: 24px;
    }
  }
}
</style>
