<script>
    import "carbon-components-svelte/css/white.css";
    // import JSONTree from "svelte-json-tree";
    import { JsonView } from "@zerodevx/svelte-json-view";
    import {
        TextInput,
        Button,
        ContentSwitcher,
        Switch,
        TextArea,
    } from "carbon-components-svelte";

    export let result = "";
    export let responseStatus;
    export let responseContentType;
    export let time;
</script>

{@debug result}
<div class="response">
    {#if result}
        <div>
            <label
                >Status:<span class="statusValue">{responseStatus}</span></label
            >
            <label>Time: <span class="statusValue">{time}</span></label>
        </div>
    {/if}
    {#if responseContentType == "application/json"}
        <!-- <div class="wrap" style="overflow: scroll;">
            <JsonView calss="tree" json={JSON.parse(result)} />
        </div> -->
        <!-- <JsonView class="tree" json={JSON.parse(result)} /> -->
        <!-- <JSONTree
            class="tree"
            value={JSON.parse(result)}
            defaultExpandedLevel={3}
        /> -->
        <textarea bind:value={result} placeholder="返回结果" rows={12} />
    {:else}
        <textarea bind:value={result} placeholder="返回结果" rows={12} />
    {/if}
</div>

<style>
    .response {
        text-align: left;

        border: 1px solid silver;
        margin-top: 5px;
        width: auto;
        height: auto;
        text-align: left;
        padding: 8px;
    }

    textarea {
        width: 100%;
        font-size: 15px;
        height: 100%;
    }
    .statusValue {
        color: green;
    }
    .wrap {
        overflow: scroll;
    }
</style>
