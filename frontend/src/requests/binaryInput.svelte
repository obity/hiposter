<script>
    import "carbon-components-svelte/css/white.css";
    import { FileUploader, Button } from "carbon-components-svelte";
    import TrashCan from "carbon-icons-svelte/lib/TrashCan.svelte";

    let fileUploader;
    export let files = [];
</script>

<div style="overflow: auto;height:280px">
    <FileUploader
        kind="tertiary"
        bind:this={fileUploader}
        multiple
        labelTitle="Upload File"
        buttonLabel="add file "
        status="complete"
        bind:files
    />

    <Button
        kind="danger-tertiary"
        size="small"
        disabled={!files.length}
        iconDescription="Clear file"
        on:click={fileUploader.clearFiles}
        on:click={() => (files = [])}
        icon={TrashCan}
    />
</div>

<style>
</style>
