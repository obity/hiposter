<script>
    import "carbon-components-svelte/css/white.css";
    import {
        TextInput,
        Button,
        ContentSwitcher,
        Switch,
        TextArea,
    } from "carbon-components-svelte";

    export let result;
    export let responseStatus;
    export let time;
</script>

<div class="response">
    {#if result}
        <div>
            <label
                >Status:<span class="statusValue">{responseStatus}</span></label
            >
            <label>Time: <span class="statusValue">{time}</span></label>
        </div>
    {/if}
    <textarea bind:value={result} placeholder="返回结果" rows={12} />
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
</style>
