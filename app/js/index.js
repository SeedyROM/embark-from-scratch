import EmbarkJS from 'Embark/EmbarkJS';

// import your contracts
// e.g if you have a contract named SimpleStorage:
import Account from '../../embarkArtifacts/contracts/Account';


EmbarkJS.onReady(async (err) => {
  const app = document.querySelector("#app");

  // Add a test post for posterity
  const pseudoNow = Number(new Date()) % Math.pow(2, 16);
  const post = await Account.methods.createPost(`Test Message @ ${pseudoNow.toString()}`).send();
  console.log(post);

  // You can execute contract calls after the connection
  const postCount = await Account.methods.postCount().call();
  app.innerHTML = postCount;
});
