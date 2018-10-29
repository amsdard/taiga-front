###
# Copyright (C) 2014-2015 Taiga Agile LLC <taiga@taiga.io>
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
# File: userstory-sidebar.controller.coffee
###

taiga = @.taiga

mixOf = @.taiga.mixOf
groupBy = @.taiga.groupBy
bindOnce = @.taiga.bindOnce
bindMethods = @.taiga.bindMethods


class UserStorySidebarController extends taiga.Controller
    @.$inject = ["$rootScope",
                 "$scope",
                 "$translate",
                 "$tgQueueModelTransformation"]

    sidebarOpen = false

    constructor: (@rootScope, $scope, @translate, @scope) ->

        @rootScope.$on "story:details",(ctx,params) ->
            if sidebarOpen is true
                $scope.us = undefined
                $scope.project = undefined
                $scope.sidebarOpen = false
                sidebarOpen = false
                $scope.apply()
            $scope.prop = 'us'
            $scope.us = params.us
            $scope.project = params.project
            $scope.item = $scope.us
            $scope.sidebarOpen = true

    sleep = (ms) ->
        start = new Date().getTime()
        continue while new Date().getTime() - start < ms

    getNavKey: () ->
        return 'project-userstories-detail'

    closeSidebar: ->
        @rootScope.$broadcast("close:sidebar")

angular.module('taigaComponents').controller('UserstorySidebar', UserStorySidebarController)
