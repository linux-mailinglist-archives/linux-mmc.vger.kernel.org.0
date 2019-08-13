Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF02D8BBC0
	for <lists+linux-mmc@lfdr.de>; Tue, 13 Aug 2019 16:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfHMOl3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 13 Aug 2019 10:41:29 -0400
Received: from esa01.kjsl.com ([198.137.202.87]:35688 "EHLO esa01.kjsl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbfHMOl3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 13 Aug 2019 10:41:29 -0400
Received: from unknown (HELO people.danlj.org) ([IPv6:2607:7c80:54:5:7609:68e3:940d:b47c])
  by esa01.kjsl.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:41:28 +0000
Received: from people.danlj.org (localhost [127.0.0.1])
        by people.danlj.org (8.14.7/8.14.7) with ESMTP id x7DEfRul001939
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Aug 2019 10:41:27 -0400
Received: (from johnsonm@localhost)
        by people.danlj.org (8.14.7/8.15.2/Submit) id x7DEfRjZ001938;
        Tue, 13 Aug 2019 10:41:27 -0400
Date:   Tue, 13 Aug 2019 10:41:27 -0400
From:   "Michael K. Johnson" <johnsonm@danlj.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: Re: [PATCH v3 3/2] mmc: host: sdhci-pci: add Genesys Logic GL975x
 support
Message-ID: <20190813144127.GA1926@people.danlj.org>
References: <20190726020754.GA12078@people.danlj.org>
 <62a756ff-6432-fd43-5e90-038eb28045cd@intel.com>
 <20190812225826.GC30758@people.danlj.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812225826.GC30758@people.danlj.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Aug 12, 2019 at 06:58:26PM -0400, Michael K. Johnson wrote:
> Add support for the GL9750 and GL9755 chipsets.

This patch has a bug introduced in responding to feedback; it invokes
the wrong reset functions.  New v4 patch coming next will fix that,
is based on the first two (unchanged) v3 patches to add pll enable
support and add the GLI PCI identifier.
