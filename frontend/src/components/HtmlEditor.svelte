<script>
    import CodeEditor from "./CodeEditor.svelte";
    export let value = "";
</script>

<CodeEditor bind:value langtype="html" />
