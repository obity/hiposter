<script>
    // import "carbon-components-svelte/css/white.css";
    // import JSONTree from "svelte-json-tree";
    import { JsonView } from "@zerodevx/svelte-json-view";
    import {
        TextInput,
        Button,
        ContentSwitcher,
        Switch,
        TextArea,
    } from "carbon-components-svelte";
    import { Tabs, Tab, TabContent } from "carbon-components-svelte";
    import BodyOutput from "./responses/bodyOutput.svelte";
    import HeadersOutput from "./responses/headersOutput.svelte";

    export let result = "";
    export let responseStatus = "";
    export let responseHeaders;
    export let responseContentType;
    export let time;
</script>

<div class="response" style="height:300px;">
    {#if result}
        <div class="status">
            <span>Status:</span><span class="statusValue">{responseStatus}</span
            >
            <span>Time:</span> <span class="statusValue">{time}</span>
        </div>
        <div style="position: relative;top: -20px;">
            <Tabs autoWidth>
                <Tab label="Body" />
                <Tab label="Headers" />

                <svelte:fragment slot="content">
                    <TabContent style="padding:8px"
                        ><BodyOutput bind:result /></TabContent
                    >
                    <TabContent
                        ><HeadersOutput
                            bind:headers={responseHeaders}
                        /></TabContent
                    >
                </svelte:fragment>
            </Tabs>
        </div>
    {:else}<div style="width:100%;">
            <span>Response</span>
        </div>{/if}
</div>

<style>
    .status {
        text-align: right;
        position: relative;
        top: 10px;
        left: -10px;
    }
    .response {
        border: 1px solid silver;
        width: auto;
        height: auto;
        text-align: left;
    }
    .statusValue {
        color: green;
        padding: 5px;
    }
</style>
