import QtQuick
import Qt.labs.qmlmodels

import "JsonData.js" as CachedJsonData

TableModel {
    TableModelColumn { display: "driverId" }
    TableModelColumn { display: "code" }
    TableModelColumn { display: "url" }
    TableModelColumn { display: "givenName" }
    TableModelColumn { display: "familyName" }
    TableModelColumn { display: "dateOfBirth" }
    TableModelColumn { display: "nationality" }

    rows: CachedJsonData.drivers
}
