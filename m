Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB84B48BE
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 10:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404613AbfIQIGP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Sep 2019 04:06:15 -0400
Received: from ns.iliad.fr ([212.27.33.1]:46484 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404611AbfIQIGO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Sep 2019 04:06:14 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 7546120897;
        Tue, 17 Sep 2019 10:06:13 +0200 (CEST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 17E4620840;
        Tue, 17 Sep 2019 10:06:13 +0200 (CEST)
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20190916171509.GG25745@shell.armlinux.org.uk>
Cc:     linux-mmc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr>
Date:   Tue, 17 Sep 2019 10:06:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916171509.GG25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Sep 17 10:06:13 2019 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/09/2019 19:15, Russell King - ARM Linux admin wrote:

> The platform has an iommu, which is in pass-through mode, via
> arm_smmu.disable_bypass=0.

Could be 954a03be033c7cef80ddc232e7cbdb17df735663
"iommu/arm-smmu: Break insecure users by disabling bypass by default"

Although it had already landed in v5.2

Regards.
