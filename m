Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 934D333EE5
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 08:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFDGTF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 02:19:05 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40824 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfFDGTF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 02:19:05 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x546Ix78116595;
        Tue, 4 Jun 2019 01:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559629139;
        bh=jvqL2oo7kskDDbMtCsx2Fz2AQjGWe3N34LruTZ8+CvE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=A/pg8LgY5XbvJdRfUVgHoYuMS/6Yer5ipsxWstl/0yjWrMGEyz1fM2Y9vY0sR6osh
         mpBUZGoxYi7F59A8aJ+lUZBmMYvmRh671YtwJhPofdPK4teJST3T+DHbKjK3UIF9FV
         cT3ZJti06b0FZ70l4qg5rrbJDcJ9ZS2K2/4Zn4Cg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x546IxUV045962
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 01:18:59 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 01:18:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 01:18:58 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x546ItYQ079544;
        Tue, 4 Jun 2019 01:18:56 -0500
Subject: Re: [PATCH 0/4] Add Support for MMC in J721E
To:     Faiz Abbas <faiz_abbas@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <adrian.hunter@intel.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>, <nm@ti.com>
References: <20190604060914.10886-1-faiz_abbas@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <2f45cef2-c4ca-0404-b205-fabbb92a40fb@ti.com>
Date:   Tue, 4 Jun 2019 11:48:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604060914.10886-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 04/06/19 11:39 AM, Faiz Abbas wrote:
> The following patches add driver support for MMC SDHCI interfaces on
> TI's J721E devices. The 8 bit and 4 bit instances have phys which are
> different from the am65x interfaces as well as different from each
> other which leads to 3 different compatibles and a bunch of flags for
> indicating the differences.
> 
> Depends on Nishanth's initial J721E patches here:
> https://lore.kernel.org/patchwork/cover/1077382/

This dependency is only for testing, not for applying these, right?

Thanks,
Sekhar
