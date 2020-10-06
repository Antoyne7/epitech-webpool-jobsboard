// Service de requêtage Ajax
import param from '@/param/param'	// paramétrages
import axios from 'axios'

export default {

  getListe(type) {
    return axios.get(param[type])
      .then(response => {
        return response.data
      })
  },

  getInformations(type, params) {
    return axios.get(param[type] + '/' + params, {
      headers: {
        'Content-Type': 'multipart/form-data'
      },
    })
      .then(response => {
        return response.data
      })
  },

  pushInformations(type, params) {
    return axios.post(param[type], params, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })
      .then(response => {
        return response.data
      })
  },
}
