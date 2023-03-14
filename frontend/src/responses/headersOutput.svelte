<script>
    import "carbon-components-svelte/css/white.css";
    import { TextInput } from "carbon-components-svelte";
    export let headers = [{ key: "", value: "" }];
</script>

<div style="overflow: auto;height:100%">
    <div class="title">
        <div class="clos"><span>KEY</span></div>
        <div class="clos" style="border-left: 0.5px solid silver;">
            <span>VALUE</span>
        </div>
    </div>
    {#each headers as { key, value } (key)}
        <div class="row">
            <TextInput
                class="clos"
                placeholder="Key"
                bind:value={key}
                size="sm"
                light
                style="border-bottom: 0;"
            />

            <TextInput
                class="clos"
                placeholder="Value"
                bind:value
                size="sm"
                light
                style="margin-left:0px;border-bottom: 0;border-left:1px solid silver"
            />
        </div>
    {/each}
</div>

<style>
    .title {
        display: flex;
        border-left: 1px solid silver;
        border-right: 1px solid silver;
        border-bottom: 0.5px solid silver;
        border-top: 1px solid silver;
        width: auto;
        align-items: center;
    }
    span {
        margin-left: 15px;
        font-weight: bold;
    }
    .row {
        display: flex;
        border-left: 1px solid silver;
        border-right: 1px solid silver;
        border-bottom: 0.5px solid silver;
        border-top: 0px solid silver;
        width: auto;
        align-items: center;
    }
    .clos {
        display: flex;
        width: 100%;
        height: 30px;
        align-items: center;
        text-align: left;
    }
</style>
