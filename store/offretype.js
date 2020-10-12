export const state = () => ({
  types: []
})

export const mutations = {
  toggleType(state, type) {
    if (state.types.includes(type)) {
      state.types.splice(state.types.indexOf(type), 1)
    } else {
      state.types.push(type)
    }
  },
  removeTypes(state) {
    state.types = []
  },
  setTypes(state, typesArray) {
    typesArray.forEach(type => {
      if (!state.types.includes(type.nom)) {
        state.types.push(type.nom)
      }
    })
  }
}
