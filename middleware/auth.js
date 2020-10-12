export default function ({store, redirect}) {
  console.log(store.state)
  if (!store.state.auth.loggedIn && store.state.auth.user === null) {
    console.log('Je me déclenchezer')
    return redirect('/login')
  }
}
