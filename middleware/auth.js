export default function ({store, redirect}) {
  console.log(store.state,redirect)
  if (!store.state.token) {
    // return redirect('/login');
  }
}
