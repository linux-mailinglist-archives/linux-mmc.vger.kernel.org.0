Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6B68AAD9
	for <lists+linux-mmc@lfdr.de>; Tue, 13 Aug 2019 00:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfHLW5b (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 12 Aug 2019 18:57:31 -0400
Received: from esa01.kjsl.com ([198.137.202.87]:17165 "EHLO esa01.kjsl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfHLW5b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 12 Aug 2019 18:57:31 -0400
Received: from unknown (HELO people.danlj.org) ([IPv6:2607:7c80:54:5:7609:68e3:940d:b47c])
  by esa01.kjsl.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 22:57:30 +0000
Received: from people.danlj.org (localhost [127.0.0.1])
        by people.danlj.org (8.14.7/8.14.7) with ESMTP id x7CMvUNQ030821
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 18:57:30 -0400
Received: (from johnsonm@localhost)
        by people.danlj.org (8.14.7/8.15.2/Submit) id x7CMvUg6030820;
        Mon, 12 Aug 2019 18:57:30 -0400
Date:   Mon, 12 Aug 2019 18:57:30 -0400
From:   "Michael K. Johnson" <johnsonm@danlj.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: Re: [PATCH v3 2/3] PCI: Add Genesys Logic, Inc. Vendor ID
Message-ID: <20190812225730.GB30758@people.danlj.org>
References: <20190726020754.GA12078@people.danlj.org>
 <62a756ff-6432-fd43-5e90-038eb28045cd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62a756ff-6432-fd43-5e90-038eb28045cd@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add the Genesys Logic, Inc. verndor ID to pci_ids.h.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70e86148cb1e..4f7e12772a14 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2403,6 +2403,8 @@
 #define PCI_DEVICE_ID_RDC_R6061		0x6061
 #define PCI_DEVICE_ID_RDC_D1010		0x1010
 
+#define PCI_VENDOR_ID_GLI		0x17a0
+
 #define PCI_VENDOR_ID_LENOVO		0x17aa
 
 #define PCI_VENDOR_ID_QCOM		0x17cb
