Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10514C0CDE
	for <lists+linux-mmc@lfdr.de>; Wed, 23 Feb 2022 07:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiBWG72 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 23 Feb 2022 01:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiBWG71 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Feb 2022 01:59:27 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CAE4EF58
        for <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2022 22:58:59 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id j2so17232421oie.7
        for <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2022 22:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cerclemallorca-org.20210112.gappssmtp.com; s=20210112;
        h=from:reply-to:mime-version:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hRYmFiQorCA1GkHAsgNXSN1gfPsqLlp/sCZza5USlfQ=;
        b=CEY3Z7ExvwMC3+pRPgGvSM05XwmF0n8RBjUpvRNgUEqVN+nIfw6Y2WqlTQ4CuYXI1i
         qX+VCby0/HQqCNTirpbFu+LQfgm0OrvKgtOsS1IE1vJkef2CdVqbpqS5Q/ny8oyAMaxz
         h8Ujzky9uKYs75szrdL8/+JakH8nJtL3W2qpuN4mfdg+jLesHuhE6f4CIzehMVpzioXE
         qUMIP0i4i59OgUOR6LsV1Jh0Ry1xmYBLnslLTJOiqdrURoXSR4ca7qTRPxY9k4AsMOJH
         SUIXPs2gcGi29ARyT+AyamOkkiZrEOaXtGQbliKQ8fhcJPqUwe+HPlvSQoIYeffSvXJH
         ylug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:reply-to:mime-version:date:message-id
         :subject:to:content-transfer-encoding;
        bh=hRYmFiQorCA1GkHAsgNXSN1gfPsqLlp/sCZza5USlfQ=;
        b=HQxO+1hBvjkcXia5Nt5e4kcfsmwWY5qPnMD3kEzQ27YwlCXh6z+3uCTFVDvtbDO47t
         sLLvOhqbBYDLdasWJRiXcyA3OC57n50DvOYbR4tujmrOwzKj5TuNOEVzhuLocloZqhCO
         G5UMajDT63H20BiskDyBGi8D/Xxx4I+zkgkcKPTg5LTOofdtBoDIdag3HqMp3kKE5Bfn
         88SF22yxgfXTvotiW22AiwWkIzIImEKhD8cuwvuGGCUdxH0x3AhajzvwhxDHmjJ2XzXL
         Y9mQT+qXy6KtT1oZrCfHrc0GFuJwyYdKpJDvTxLinTkPm1nb2TEzSXquNeoTSptk80Ma
         ccDw==
X-Gm-Message-State: AOAM5300agfQp8fu2yGlYfcrPSNrwH+FZGuFL9JXLtzMaHrECvi30ZPm
        NefeYER9xQVQpQc5Ri6M7Cn6AbpbDTh4oFMI7ATz7kmaUUz45g==
X-Google-Smtp-Source: ABdhPJwOBdY2YW8MMQFYEujTMLj23yZSSHydhwoEgmXCVd6BWPooI7YU/lKU36+QESGS06yPCqyr85InvAToxa6uXFA=
X-Received: by 2002:aca:3446:0:b0:2ce:6ee7:2d18 with SMTP id
 b67-20020aca3446000000b002ce6ee72d18mr3963982oia.326.1645599538685; Tue, 22
 Feb 2022 22:58:58 -0800 (PST)
Received: from 729955949434 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Feb 2022 22:58:58 -0800
From:   =?UTF-8?Q?Cercle_d=E2=80=99Economia_de_Mallorca?= 
        <tic@cerclemallorca.org>
Reply-To: cercle@cerclemallorca.es
X-Mailer: WPMailSMTP/Mailer/gmail 3.3.0
MIME-Version: 1.0
Date:   Tue, 22 Feb 2022 22:58:58 -0800
Message-ID: <CAN_rQh49UMLsi-2p3mJghrrFQ1XsLi=jUVdf_NUyBCb0GPGEEA@mail.gmail.com>
Subject: Solicitud de socio
To:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SHORT_SHORTNER,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Buen d=C3=ADa =E2=9D=A4=EF=B8=8F You have unread messages from Ashley (2)! =
Click Here:
https://clck.ru/btETq?ykt7 =E2=9D=A4=EF=B8=8F 61om6xol:

Hemos recibido su solicitud para ser miembro del Cercle de Mallorca
Si tiene alguna duda puede contactar:

971 71 71 67
cercle@cerclemallorca.org
