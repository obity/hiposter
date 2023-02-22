<script>
  import logo from "./assets/images/logo-universal.png";

  import { Greet, Run } from "../wailsjs/go/main/App.js";
  import Head from "./Head.svelte";
  import Request from "./Request.svelte";
  import Response from "./Response.svelte";
  import { debug } from "svelte/internal";
  import { UserRole } from "carbon-icons-svelte";

  let resultText = "Please enter your name below 👇";
  let name;
  let method;
  let url = "";
  let bodyContent;
  let result;
  let contentType = "application/none";
  let btnValue = "Send";
  let disabled = false;
  let responseStatus;
  let time;
  let responseContentType;
  let responseHeaders;
  let headers;
  let args = "";
  let params = [{ id: 0, key: "", value: "" }];
  let files;
  $: {
    args = "";
    for (const v of params) {
      if (v.key != "") {
        if (args == "") {
          args += "?" + v.key + "=" + v.value;
        } else {
          args += "&" + v.key + "=" + v.value;
        }
      }
    }
    args = args;
  }
  function updateArgs() {
    url = url.split("?")[0] + args;
  }

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
    let start = new Date().getTime();
    Run(method, url, bodyContent, contentType, headers).then((res) => {
      let end = new Date().getTime();
      time = end - start + "ms";
      disabled = false;
      btnValue = "Send";
      responseStatus = res.httpStatus;
      responseContentType = res.contentType;
      responseHeaders = res.headers;
      if (responseContentType.startsWith("application/json")) {
        let jsonPretty = JSON.stringify(JSON.parse(res.bodyContent), null, 20);

        return (result = jsonPretty);
      } else {
        return (result = res.bodyContent);
      }
    });
  }
</script>

<main style="margin-left: 20px; margin-right:20px; min-width:400px">
  <Head on:click={run} bind:theMethod={method} {btnValue} bind:url />
  <Request
    on:click={updateArgs}
    bind:bodyContent
    bind:contentType
    bind:headers
    bind:params
    bind:files
  />
  <Response
    bind:result
    {responseStatus}
    {time}
    {responseHeaders}
    {responseContentType}
  />
</main>

<style>
</style>
