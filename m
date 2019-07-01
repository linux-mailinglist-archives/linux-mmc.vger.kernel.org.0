Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03CCD167DF
	for <lists+linux-mmc@lfdr.de>; Tue,  7 May 2019 18:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfEGQ1L (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 7 May 2019 12:27:11 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59890 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfEGQ1K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 May 2019 12:27:10 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x47GR8hw033836;
        Tue, 7 May 2019 11:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557246428;
        bh=P9OKlobsMuFk7eV/sCL4oYA9ZbX2O0+AEbA1PMWuJag=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uaAdpacX8LV5aJrKTlHW/sebP6Gdva1LW0wIc0ec9AccICX1k/qVxqvEzuYuDYWv1
         kLICOGTT/w1WzFZvJNg7EjI6/fLhAscx3S3j9J7/Vs24YumCxETQXka1LDDeLUPQU8
         6AKaoP7Z84Mi7tCEvuZjz0k+YBNCAyQxunu4QORU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x47GR8IN110351
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 May 2019 11:27:08 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 7 May
 2019 11:27:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 7 May 2019 11:27:07 -0500
Received: from [10.250.139.87] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x47GR5X6108985;
        Tue, 7 May 2019 11:27:06 -0500
Subject: Re: [PATCH 2/2] mmc: sdhci_am654: Fix SLOTTYPE write
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>
References: <20190425155727.20010-1-faiz_abbas@ti.com>
 <20190425155727.20010-3-faiz_abbas@ti.com>
 <c2dcc343-395f-03a2-67a8-d89ab6a6b192@intel.com>
From:   Faiz Abbas <a0230074@ti.com>
Message-ID: <db0b0790-4556-8a3b-2ae1-fcb4b1beb4b3@ti.com>
Date:   Tue, 7 May 2019 21:57:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c2dcc343-395f-03a2-67a8-d89ab6a6b192@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On 26/04/19 11:30 AM, Adrian Hunter wrote:
> On 25/04/19 6:57 PM, Faiz Abbas wrote:
>> In the call to regmap_update_bits() for SLOTTYPE, the mask and value
>> fields are exchanged. Fix this.
> 
> Could you also comment on whether this has any known effect on the driver.
> 

This call was basically a NOP but it was the correct way around in
u-boot so it was just taking that value instead. No effect that was
known to me. Found this out just by inspection.

Thanks,
Faiz
