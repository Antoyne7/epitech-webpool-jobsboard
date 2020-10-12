export default function ({store, redirect}) {
  if (!store.state.auth.loggedIn && store.state.auth.user === null) {
    console.log('Je me déclenchezer')
    return redirect('/login')
  }
}
