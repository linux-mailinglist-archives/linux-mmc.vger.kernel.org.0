Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505DD1EB3E2
	for <lists+linux-mmc@lfdr.de>; Tue,  2 Jun 2020 05:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgFBDsO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 1 Jun 2020 23:48:14 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40042 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFBDsO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 1 Jun 2020 23:48:14 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B4A3200905;
        Tue,  2 Jun 2020 05:48:12 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 287252005FD;
        Tue,  2 Jun 2020 05:48:07 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B451640280;
        Tue,  2 Jun 2020 11:48:00 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mpa@pengutronix.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 0/3] Convert i.MX/MXS mmc binding to json-schema
Date:   Tue,  2 Jun 2020 11:37:43 +0800
Message-Id: <1591069066-12727-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series converts i.MX and MXS mmc binding to json-schema,
fix some minor issues in original binding doc, such as node name should
be 'mmc', compatible name for i.MX27, reg/interrupts should be required
properties etc..

Anson Huang (3):
  dt-bindings: mmc: Convert imx esdhc to json-schema
  dt-bindings: mmc: Convert imx mmc to json-schema
  dt-bindings: mmc: Convert mxs mmc to json-schema

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |  67 -----------
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     | 122 +++++++++++++++++++++
 .../devicetree/bindings/mmc/fsl-imx-mmc.txt        |  23 ----
 .../devicetree/bindings/mmc/fsl-imx-mmc.yaml       |  51 +++++++++
 Documentation/devicetree/bindings/mmc/mxs-mmc.txt  |  27 -----
 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml |  56 ++++++++++
 6 files changed, 229 insertions(+), 117 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/mxs-mmc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml

-- 
2.7.4

