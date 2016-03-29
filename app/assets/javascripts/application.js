// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require flash_messages
//= require cocoon
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

$(document).ready(function() { 

 $("tr[data-link]").click(function() {
        window.location = $(this).data('link');
 });

 $('.student-pack-records').addClass('hidden');
 $('.student-details').addClass('hidden');
 $('.student-enrolments').addClass('hidden');

 $('.records-title').on("click", function() {
    $('.student-pack-records').removeClass('hidden');
    $('.student-details').addClass('hidden');
    $('.student-enrolments').addClass('hidden');
 });

 $('.details-title').on("click", function() {
    $('.student-pack-records').addClass('hidden');
    $('.student-details').removeClass('hidden');
    $('.student-enrolments').addClass('hidden');
 });

 $('.enrolments-title').on("click", function() {
    $('.student-pack-records').addClass('hidden');
    $('.student-details').addClass('hidden');
    $('.student-enrolments').removeClass('hidden');
});

 $('.reset-student-page').on('click', function (){
    $('.student-pack-records').addClass('hidden');
    $('.student-details').addClass('hidden');
    $('.student-enrolments').addClass('hidden');
});

 $(".subject-page").addClass('hidden');
 $(".offer-page").addClass('hidden');
 $(".pack-page").addClass('hidden');
 $(".enclosure-page").addClass('hidden');
 $(".fee-page").addClass('hidden');
 $(".user-page").addClass('hidden');
 $(".all-users").addClass('hidden');

 $(".subject-a").on("click", function() {
    $(".subject-page").removeClass('hidden');
    $(".offer-page").addClass('hidden');
    $(".pack-page").addClass('hidden');
    $(".enclosure-page").addClass('hidden');
    $(".fee-page").addClass('hidden');
    $(".user-page").addClass('hidden');
    $(".all-users").addClass('hidden');
    $(".user-admin").removeClass('hidden');
});

 $(".offer-a").on("click", function() {
    $(".subject-page").addClass('hidden');
    $(".offer-page").removeClass('hidden');
    $(".pack-page").addClass('hidden');
    $(".enclosure-page").addClass('hidden');
    $(".fee-page").addClass('hidden');
    $(".user-page").addClass('hidden');
    $(".all-users").addClass('hidden');
    $(".user-admin").removeClass('hidden');
 });

  $(".pack-a").on("click", function() {
    $(".subject-page").addClass('hidden');
    $(".offer-page").addClass('hidden');
    $(".pack-page").removeClass('hidden');
    $(".enclosure-page").addClass('hidden');
    $(".fee-page").addClass('hidden');
    $(".user-admin-page").addClass('hidden');
    $(".user-parent-page").addClass('hidden');
    $(".user-student-page").addClass('hidden');
    $(".all-users").addClass('hidden');
    $(".user-admin").removeClass('hidden');
 });

  $(".enclosure-a").on("click", function() {
    $(".subject-page").addClass('hidden');
    $(".offer-page").addClass('hidden');
    $(".pack-page").addClass('hidden');
    $(".enclosure-page").removeClass('hidden');
    $(".fee-page").addClass('hidden');
    $(".user-page").addClass('hidden');
    $(".all-users").addClass('hidden');
    $(".user-admin").removeClass('hidden');
 });

 $(".fee-a").on("click", function() {
    $(".subject-page").addClass('hidden');
    $(".offer-page").addClass('hidden');
    $(".pack-page").addClass('hidden');
    $(".enclosure-page").addClass('hidden');
    $(".fee-page").removeClass('hidden');
    $(".user-page").addClass('hidden');
    $(".all-users").addClass('hidden');
    $(".user-admin").removeClass('hidden');
 });

 $(".user-admin").on("click", function() {
    $(".subject-page").addClass('hidden');
    $(".offer-page").addClass('hidden');
    $(".pack-page").addClass('hidden');
    $(".enclosure-page").addClass('hidden');
    $(".fee-page").addClass('hidden');
    $(".user-page").removeClass('hidden');
    $(".user-admin").addClass('hidden');
    $(".all-users").removeClass('hidden');
 });

});

