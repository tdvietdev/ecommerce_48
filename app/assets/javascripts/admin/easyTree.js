(function ($) {
  $.fn.EasyTree = function (options) {
    var defaults = {
      selectable: true,
      deletable: false,
      editable: false,
      addable: false,
      i18n: {
        deleteNull: 'Select a node to delete',
        deleteConfirmation: 'Delete this node?',
        confirmButtonLabel: 'Okay',
        editNull: 'Select a node to edit',
        editMultiple: 'Only one node can be edited at one time',
        addMultiple: 'Select a node to add a new node',
        collapseTip: 'collapse',
        expandTip: 'expand',
        selectTip: 'select',
        unselectTip: 'unselet',
        editTip: 'edit',
        addTip: 'add',
        deleteTip: 'delete',
        cancelButtonLabel: 'cancle'
      }
    };
    options = $.extend(defaults, options);
    this.each(function () {
      var easyTree = $(this);
      $.each($(easyTree).find('ul > li'), function () {
        var text;
        if ($(this).is('li:has(ul)')) {
          var children = $(this).find(' > ul');
          $(children).remove();
          text = $(this).html();
          $(this).html('<span><span class="glyphicon"></span><span ' +
              'class="m_span "></span> </span>');
          $(this).find(' > span > span').addClass('glyphicon-folder-open');
          $(this).find(' > span > .m_span').html(text);
          $(this).append(children);
        }
        else {
          text = $(this).html();
          $(this).html('<span><span class="glyphicon"></span> ' +
              '<span class="m_span "></span> </span>');
          $(this).find(' > span > span').addClass('glyphicon-file');
          $(this).find(' > span > .m_span').html(text);
        }
      });
      
      $(easyTree).find('li:has(ul)').addClass('parent_li').
      find(' > span').attr('title', options.i18n.collapseTip);
    });
  };
})(jQuery);
