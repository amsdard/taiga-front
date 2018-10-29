###
# Copyright (C) 2014-2017 Taiga Agile LLC <taiga@taiga.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# File: userstory-sidebar.directive.coffee
###

UserStorySidebarDirective = ($rootscope, $template, $modelTransform, $q, $rs, $repo) ->
    link = (scope, el, attrs, ctrl) ->

        $rootscope.$on "close:sidebar", ->
            scope.sidebarOpen = false

        $rootscope.$on "story:details",(ctx,params) ->
            $('#description-box').val(scope.us.description)
            el.addClass('open')

        scope.$watch "sidebarOpen",(val)->
            if val
                el.addClass('open')
            else
                el.removeClass('open')


        attrs.$observe "open", (open) ->
            open = scope.$eval(open)
            if open
                el.addClass('open')
            else
                el.removeClass('open')

        submit = (event) ->
            promise = $repo.save(scope.us, true)
            promise.then (data) ->
                data = {
                    "status": scope.us.status
                   }
                $rootscope.$broadcast("story:updated", data)

            promise.then null, (data) ->
                form.setErrors(data)
                if data._error_message
                    $confirm.notify("error", data._error_message)

        el.on "click", ".save-desc", (event) ->
            scope.us.description = $('#description-box').val()
            scope.$apply()
            submit(event)

        el.on "click", ".is-blocked", (event) ->
            scope.us.is_blocked = not scope.us.is_blocked
            scope.$apply()
            submit(event)

        el.on "click", ".is-important", (event) ->
            scope.us.is_important = not scope.us.is_important
            scope.$apply()
            submit(event)

        el.on "click", ".team-requirement", (event) ->
            scope.us.team_requirement = not scope.us.team_requirement
            scope.$apply()
            submit(event)

        el.on "click", ".client-requirement", (event) ->
            scope.us.client_requirement = not scope.us.client_requirement
            scope.$apply()
            submit(event)
    return {
        scope: {
            item: "=",
            project: "=",
            name: "="
        },
        bindToController: true,
        controller: "UserstorySidebar",
        controllerAs: "vm",
        templateUrl: 'components/userstory-sidebar/sidebar.html',
        link: link
        restrict: "EA"
    }

angular.module('taigaComponents').directive("tgUserstorySidebar", ["$rootScope", "$tgTemplate", "$tgQueueModelTransformation", "$q","$tgResources", "$tgRepo", UserStorySidebarDirective])

