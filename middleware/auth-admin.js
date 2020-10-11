export default function ({store, redirect, auth}) {
  if (!store.state.auth.loggedIn && store.state.auth.user.role !== 2) {
    return redirect('/login')
  }
}
