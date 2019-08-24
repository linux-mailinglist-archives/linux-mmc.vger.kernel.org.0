Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE2FD9BC3B
	for <lists+linux-mmc@lfdr.de>; Sat, 24 Aug 2019 08:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfHXGbm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 24 Aug 2019 02:31:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:56603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfHXGbl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 24 Aug 2019 02:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566628287;
        bh=dQz3ifW32mv8e7zxPbDceBUBeoAhi0dwNOeJVA2mzHk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UygP3BqmA6xXsvk1K/9+C//EiRgf4XtxkA0x26pPyH93kyIOz3oobIGRlfGuVv9P3
         BCzDDudqZ8Rl01trpgoS5kc9IHlEOZaraaju1R8ByGZypM+Z1l3ptjERTL7QCPNSAN
         gOwryGU0o+gAQeL1N3L+nPXzML4737tAVerfw3hs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.106]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M1ps8-1i3bRG3yTg-002G6u; Sat, 24 Aug 2019 08:31:27 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] mmc: bcm2835: Take SWIOTLB memory size limitation into account
Date:   Sat, 24 Aug 2019 08:31:04 +0200
Message-Id: <1566628264-3289-1-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:4+G3s2LSrxXI04mFuIYNPdch6v5pM042aUPYhU+vYjM5zcNkPTb
 ceAv972u/rMg2o+/kcX1tczXIVWZCIgUUm72om6j2eRxDL/RhLnuH+pRHBDxoUEbpIqW59B
 YWcE1E+EdFpNcn/+46fEVPnWe2cYH3EcBMAWW+hFJWsCzEI37yVtWN1D0MX1XqwMuzr9hDJ
 5afQUaKSwOZxuKWVP4z1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rzi2m/qxdb8=:p9Z69Z17bsZCreW9Be7YqV
 Dm7LFN+rmHWpL3pH8YSeM42aSFq5LlphQ7tTTmxF+PXj1+HIiMpXGjvZkmJggTXTXgnvcazui
 S8ttttOZiYjakkZq0zComG3+YNmhhlHcNNZkkJKwH56sk1/mEDfBdG5FVEJVmyTvStyD/KpGL
 Zg+ItzD5RVkYad3NfZYWJS8dwq2jodxTjQrOA7iKTjGSaPFD/Uvu2UzAJrQaGWJE55vhHMJJD
 fkKUdwJFHc9orpMSZQn9WdY64i8XlWazzaAgzQhk5jrczEACO0WpK9tCFuFIUNnMQX1H1aUbg
 GEU9LFt9azqcYIeUVM5Fk3nj6xJ5J9fWBc3ZSTXz0+aGaM5OTfp6l4GpYY7c3EMJD6/SFZlYO
 LMOO03ok89LnTHvAYQJ+rGr+mmbfp6JpqPLjJgTonnSPsURS8Nv0jm3DLxrd75x+WV/FpgBer
 FyfAzpXzYhrKRQI4dl15JrLeGGCwfBEbuG85/ikI/bHouZ7uyTEoo44swmQSgMVLUxExgSafH
 1XVPmC+1+eVLCRQYtyOeH8JTd/UOyOw/ktz6jJ/GxvVM4rH5jauQhiZTpYW0I68w7ho0N9DfX
 acJ011nQ180rYBVshlg+T8XQ1JUZ7ETVQcYU3jBC2CVzlXBjpV8vEFjZ2/RBMY3IYVMR2gukl
 ipfBiDF9gBj8rHGWMWTg2RPadjXmDhoeWYdfASZtVXhftHWCKbqnWv/2IAQPMADWL8zdbKkuc
 wg1P0uPlSjPVuXbPLf9vVmZSl4UOYkoTvowNvaoN2mqlS3VpVqf2PzAPZXjnnNZovyAUUp+/b
 Ho6fjPOHpORJkCkqaD7g1nfTP8pxca5cGOnlVlXdKip4prp/iH7oaAhn5ANodGyDQTnkhWsho
 IazDdOCOd0WpTU1SpTiOH4Bz4rF8xB3AOd1Ik7s4RfzKcktdLWFXjLTfAH7SlxjzruUS3UY61
 zFMzQ8H75dgjrX1mWuy/Y+w3NrYmxpBpq+9FoX3lhdBDgkwH6XIyhmp36b6apeDLp3TfMRpg4
 mD4dgzNQegOaD451S7BwsVRaE2p0uB/0UUskoGGz0F8iiQe/NX8J3mrqvsHftsWIOKoEzWi7d
 IG0Ug/wSdzAw/BSQoDO5X6VDz47M0zVBFBW59EkKJH7hHXPaDOatcthiHXcH9Pz5NhTel8NIy
 s5LdwL6W8WRJ7DnB5+SepL4m/PjL9DfFAFP1fCK9BS7BbbHQ==
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Make sure the sdhost driver doesn't use requests bigger than SWIOTLB
can handle.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/mmc/host/bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 7e0d3a4..7ec0d95 100644
=2D-- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1314,7 +1314,7 @@ static int bcm2835_add_host(struct bcm2835_host *hos=
t)
 	}

 	mmc->max_segs =3D 128;
-	mmc->max_req_size =3D 524288;
+	mmc->max_req_size =3D min_t(size_t, 524288, dma_max_mapping_size(dev));
 	mmc->max_seg_size =3D mmc->max_req_size;
 	mmc->max_blk_size =3D 1024;
 	mmc->max_blk_count =3D  65535;
=2D-
2.7.4

