<script>
    import "carbon-components-svelte/css/white.css";
    import { TextArea } from "carbon-components-svelte";
    import { JSONEditor, Mode } from "svelte-jsoneditor";
    let content = { json: {} };
    export let value;
    $: {
        value = content.json;
    }
</script>

<div style="overflow: auto;height:260px">
    <JSONEditor
        bind:content
        mainMenuBar={false}
        navigationBar={false}
        mode={Mode.text}
        indentation={4}
        statusBar={false}
    />
</div>

<!-- <TextArea
    bind:value
    placeholder="Please enter the request data here."
    light
    style="border: 1px solid silver;overflow: auto;height:280px"
/> -->
<style>
</style>
