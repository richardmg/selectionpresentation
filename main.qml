/****************************************************************************
**
** Copyright (C) 2019 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the QtQuick module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl-3.0.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or (at your option) the GNU General
** Public license version 3 or any later version approved by the KDE Free
** Qt Foundation. The licenses are as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL2 and LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-2.0.html and
** https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick
import QtQuick.Controls
import QtQuick.Window

import Qt.labs.qmlmodels
import QtQml.Models

import "JsonData.js" as CachedJsonData

ApplicationWindow {
    id: window
    width: 800
    height: 600
    visible: true

    function requestJson() {
        let doc = new XMLHttpRequest()
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                var root = JSON.parse(doc.responseText)
                var race = root.MRData.RaceTable.Races[0]
                var raceResults = race.Results
                var drivers = []
                for (let i = 0; i < raceResults.length; ++i) {
                    drivers.push(raceResults[i].Driver)
                }
                tableView.model.rows = drivers
            }
        }

        doc.open("GET", "http://ergast.com/api/f1/2005/1/results.json")
        doc.send()
    }

    Component.onCompleted: requestJson()

    TableView {
        id: tableView
        anchors.fill: parent
        anchors.margins: 10
        columnSpacing: 1
        rowSpacing: 1
        clip: true

        ScrollBar.horizontal: ScrollBar { policy: ScrollBar.AlwaysOn }
        ScrollBar.vertical: ScrollBar { policy: ScrollBar.AlwaysOn }

        model: TableModel {
            TableModelColumn { display: "driverId" }
            TableModelColumn { display: "code" }
            TableModelColumn { display: "url" }
            TableModelColumn { display: "givenName" }
            TableModelColumn { display: "familyName" }
            TableModelColumn { display: "dateOfBirth" }
            TableModelColumn { display: "nationality" }
        }

        delegate: Rectangle {
            color: "white"
            implicitWidth: 150
            implicitHeight: 30
            Text {
                text: model.display
            }
        }
    }
}
