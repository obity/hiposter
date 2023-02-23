<script>
  // import logo from "./assets/images/logo-universal.png";

  import {  Run } from "../wailsjs/go/main/App.js";
  import Head from "./Head.svelte";
  import Request from "./Request.svelte";
  import Response from "./Response.svelte";

  let method;
  let url = "";
  let bodyContent;
  let result="";
  let contentType = "application/none";
  let btnValue = "Send";
  let responseStatus;
  let time;
  let responseContentType;
  let responseHeaders;
  let headers;
  let args = "";
  let params = [{ id: 0, key: "", value: "" }];
  let files;
  $: {
    let s = "";
    for (const v of params) {
      if (v.key != "") {
        if (s == "") {
          s += "?" + v.key + "=" + v.value;
        } else {
          s += "&" + v.key + "=" + v.value;
        }
      }
    }
    args = s;
  }
  function updateArgs() {
    url = url.split("?")[0] + args;
  }

  function run() {
    if (method.length == 0 || url.length == 0) {
      return;
    }
    btnValue = "Sending";
    result = "";
    let start = new Date().getTime();
    Run(method, url, bodyContent, contentType, headers).then((res) => {
      let end = new Date().getTime();
      time = end - start + "ms";
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
