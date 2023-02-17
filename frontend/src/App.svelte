<script>
  import logo from "./assets/images/logo-universal.png";

  import { Greet, Run } from "../wailsjs/go/main/App.js";
  import Head from "./Head.svelte";
  import Request from "./Request.svelte";
  import Response from "./Response.svelte";
  import { debug } from "svelte/internal";

  let resultText = "Please enter your name below 👇";
  let name;
  let method;
  let url = "";
  let bodyContent;
  let result;
  let contentType = "none";
  let btnValue = "Send";
  let disabled = false;
  function greet() {
    Greet(name).then((result) => (resultText = result));
  }

  function run() {
    if (method.length == 0 || url.length == 0) {
      return;
    }
    btnValue = "Sending";
    disabled = true;
    result = "";
    Run(method, url, bodyContent, contentType).then((res) => {
      disabled = false;
      btnValue = "Send";
      if (contentType == "application/json") {
        let jsonPretty = JSON.stringify(JSON.parse(res.bodyContent), null, 8);

        return (result = jsonPretty);
      } else {
        return (result = res.bodyContent);
      }
    });
  }
</script>

<main style="margin-left: 20px; margin-right:20px; min-width:400px">
  <Head
    on:click={run}
    bind:theMethod={method}
    {btnValue}
    bind:disabled
    bind:url
  />
  <Request bind:bodyContent bind:contentType />
  <Response bind:result />
</main>

<style>
</style>
