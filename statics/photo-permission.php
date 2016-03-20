<?php
$body_class = 'brand';
?>
<?php include '_head.php'; ?>

<?php include '_header.php'; ?>

<div class="content">

    <h1 class="screen-title">Add photo login</h1>
    <p>We need you to allow camera access before you can take a photo.</p>
    <form action="">
        <p><input type="file" accept="image/*" id="capture" capture="camera"><label class="button" for="capture"><img class="icon" src="img/ic_camera_red_24px.svg" alt="Camera"> Take photo</label></p>
    </form>

</div>

<footer class="footer">
    <a class="button button--subtle" href="account-default.php">Cancel</a>
</footer>

<?php include '_foot.php'; ?>
