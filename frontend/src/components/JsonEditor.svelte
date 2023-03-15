<script>
    import CodeEditor from "../components/CodeEditor.svelte";
    export let value = "";
</script>

<CodeEditor bind:value langtype="json" />
