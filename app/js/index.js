import EmbarkJS from 'Embark/EmbarkJS';

// import your contracts
// e.g if you have a contract named SimpleStorage:
import Account from '../../embarkArtifacts/contracts/Account';


EmbarkJS.onReady(async (err) => {
  const app = document.querySelector("#app");

  // You can execute contract calls after the connection
  const postCount = await Account.methods.postCount().call();
  
  app.innerHTML = postCount;
});
