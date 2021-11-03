/**
 * @fileOverview
 * The {@link apex.widget}.specialValues is used to handle input values which require special validation and formatting treatment
 **/
 
(function( widget, $, util ) {

	/**
	 * @param {String} pSelector  jQuery Selektor, das auf das Eingabeelement zeigt
	 * @param {Object} [pOptions]
	 *
	 * @function specialValues
	 * @memberOf apex.widget
	 * */
	widget.specialValues = function(pSelector, pOptions) {
		
		"use strict";
		
		var C_DISABLED_CLASS = 'apex_disabled';
		var $Item = $(pSelector);

		// Default our options and store them with the "global" prefix, because it's
		// used by the different functions as closure
		var gOptions = $.extend({
							action:    null,
							nullValue: "",
							inputName: null
							}, pOptions),
			$Item = $( pSelector, apex.gPageContext$ );

		// Erzeuge Item-Implementierungs-Objekt
		var lItemImpl = {
			// Enable/disable wird ueber eine Klasse kontrolliert, damit der Elementwert dennoch
			// beim Verarbeiten der Seite an die Datenbank geschickt wird
			enable : function() {
				$Item.removeClass(C_DISABLED_CLASS);
			},
			disable : function() {
				$Item.addClass(C_DISABLED_CLASS);
			},
			isDisabled : function() {
				return $Item.hasClass(C_DISABLED_CLASS);
			},
			setValue : function(pValue) {
				$Item.val(pValue);
			},
			getValue : function() {
				return $Item.val();
			},
			afterModify: function() {
				// Stub, keine Aktion erforderlich
			},
			nullValue : gOptions.nullValue,
			setFocusTo: $Item,
			loadingIndicator : function( pLoadingIndicator$ ) {
				var lLoadingIndicator$;
				if ( $.mobile ) {
					lLoadingIndicator$ = pLoadingIndicator$.appendTo( $( "div.ui-controlgroup-controls", $Item ) );
				} else {
					lLoadingIndicator$ = pLoadingIndicator$.appendTo( $Item );
				}
				return lLoadingIndicator$;
			},
			displayValueFor: {}
		};

		apex.item.create( this.id, lItemImpl );

	});

    // Wenn das Plugin sofort validiert werden soll, muss der change-Event gebunden werden
    if (gOptions.validateImmediate) {
        $Item.on( "change", _triggerRefresh );
    }
	
    // register the refresh event which is triggered by triggerRefresh or a manual refresh
    f$.on( "apexrefresh", refresh );

    // Löst den eigentlichen Refresh aus, der wiederum den AJAX-Call startet
    function _triggerRefresh() {
        $Item.trigger( "apexrefresh" );
    } // triggerRefresh

    // Clears the existing checkboxes/radiogroups and executes an AJAX call to get new values based
    // on the depending on fields
    function refresh( pEvent ) {
		
		var callback = function(){};

        widget.util.cascadingLov(
            $Item,
            gOptions.ajaxIdentifier,
            {
                x01:                gOptions.inputName,
                pageItems:          $( gOptions.pageItemsToSubmit, apex.gPageContext$ )
            },
            {
                success:            callback,
                target:             pEvent.target
            });

    } // refresh

}; // specialValues

})( apex.widget, apex.jQuery, apex.util );
