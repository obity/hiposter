<script>
    import CodeMirror from "svelte-codemirror-editor";
    import { json } from "@codemirror/lang-json";

    export let value = "";
    export let lang = json();
</script>

<div style="overflow: auto;height:260px">
    <CodeMirror
        bind:value
        {lang}
        basic
        lineWrapping
        useTab
        editable
        styles={{
            "&": {
                width: "100%",
                height: "260px",
                "font-size": "13px",
            },
        }}
    />
</div>

<style>
</style>
