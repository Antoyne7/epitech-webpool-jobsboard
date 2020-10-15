import param from '~/param/param'

export default ({ app }, inject) => {
  inject('getImage', (imgUrl) => {
      if (imgUrl.includes("://") || imgUrl.includes("data:image")) {
        return imgUrl;
      } else {
        return param.cheminPhoto + imgUrl;
      }
  })
}
