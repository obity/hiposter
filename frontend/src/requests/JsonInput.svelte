<script>
    import CodeMirror from "svelte-codemirror-editor";
    import { json } from "@codemirror/lang-json";

    export let value = "";
    export let lang = json();
</script>

<div style="overflow-y: auto;height:100%; width:100%;">
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
                min_height: "100%",
                "font-size": "13px",
            },
        }}
    />
</div>

<style>
</style>
