<script>
  // import logo from "./assets/images/logo-universal.png";

  import { Run } from "../wailsjs/go/main/App.js";
    import SplitPane from "./components/SplitPane.svelte";
  import Head from "./Head.svelte";
  import Request from "./Request.svelte";
  import Response from "./Response.svelte";

  let method;
  let url = "";
  let bodyContent;
  let result = "";
  let contentType = "application/none";
  let btnValue = "Send";
  let responseStatus;
  let time;
  let responseContentType;
  let responseHeaders;
  let headers;
  let args = "";
  let params = [{ id: 0, key: "", value: "" }];
  let isLoading = false;
  let isError = false;
  let errMsg = "";
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
    isLoading = true;
    isError = false;
    btnValue = "Sending";
    result = "";
    let start = new Date().getTime();
    Run(method, url, bodyContent, contentType, headers)
      .then((res) => {
        let end = new Date().getTime();
        time = end - start + "ms";
        isLoading = false;
        btnValue = "Send";
        responseStatus = res.httpStatus;
        responseContentType = res.contentType;
        responseHeaders = res.headers;
        // if (responseContentType.startsWith("application/json")) {
        //   let jsonPretty = JSON.parse(res.bodyContent);

        //   // let jsonPretty = res.bodyContent;

        //   return (result = jsonPretty);
        // } else {
        return (result = res.bodyContent);
        // }
      })
      .catch((e) => {
        isLoading = false;
        isError = true;
        btnValue = "Send";
        console.log(e);
        errMsg = e.toString();
      });
  }
</script>

<main style="margin-left: 20px; margin-right:20px;min-height:768px; min-width:1024px">
  <Head on:click={run} bind:theMethod={method} {btnValue} bind:url />
  <div style="display:flex; height:768px; min-width:1024px;overflow: hidden;">
  <SplitPane pos={50} fixed={false} min={20} max={80}>
  
  <Request
  slot="a"
    on:click={updateArgs}
    bind:bodyContent
    bind:contentType
    bind:headers
    bind:params
  />
  <Response
  slot="b"
    bind:result
    {responseStatus}
    {time}
    {responseHeaders}
    {responseContentType}
    {isLoading}
    {isError}
    {errMsg}
  />
</SplitPane>
</div>
</main>

<style>
</style>
