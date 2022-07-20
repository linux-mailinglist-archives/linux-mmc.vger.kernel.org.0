Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3259C57BCF0
	for <lists+linux-mmc@lfdr.de>; Wed, 20 Jul 2022 19:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiGTRmB (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 20 Jul 2022 13:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiGTRmB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jul 2022 13:42:01 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6794B4332D
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jul 2022 10:42:00 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31d85f82f0bso181657197b3.7
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jul 2022 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2X8HXtEcU/ZehxuPCgIPz4aOGr6MXTRGr5kvCe3jveI=;
        b=qJf5kPtScAdUlkTNjuKSESynUMGUhkrAI4Ca/2aJiOZjNFXCX2RKU0p5ZD6NiV0tsY
         S5lGtkwOJTSXaqBf+VlyFXKIBUPxTqfOU/QMMnR1fP0vLms+dwUWKBM/KkMBLBjLc5qQ
         Ts29nDLVRwT8wSfa44cUfU9QrJbONVw300PJIPM8R9oW1mRBWsPT8Tp3SkYf5dBzE7hN
         CLOCYkS64Frc2Bi1BKbtZYDsTeRg3YI5mBeNG22kW3xoDMC30hgvG2yr4rwuMM4AZXl8
         hVoKL41970Mcqmq33SjhEgokf43lgaBrM09eXsnLlY+eSAEyTF+1GXvy4btUg8X/o/0e
         eKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=2X8HXtEcU/ZehxuPCgIPz4aOGr6MXTRGr5kvCe3jveI=;
        b=AsaQEYgpLrx6DP71wMlkDiEH24GegtiZUdyKVA74nKQ7hUfr6r/idumDF4y/ias2Cj
         Rq9/tvyOuMZBVSs8oRlI4jEW6WfR2hQZylO3xV/q32YU/hCEdahNrZ4Iry5XQFU1KZRk
         10q3NsDh4YquDqvk/mZQB0X5K/6yWlbTec59f3G80TklIFsoISdd/ZCRA1l8r438Dzoi
         gjdXXLmAEsaQg5R6yxblbvV9gbo2GsVwe+7EIqtxJXM2H9/XMrb1DVdsk6fJ3C3MLuOq
         BjKTpBOFWchyXaX02DMlJx66P1pMA19HQNf46mimykTu4WYJQ9o0QXgqyn1dJ1g2COrV
         zWVg==
X-Gm-Message-State: AJIora8H7Fbez62JCYQl5J9VvZ/CIBH6Nn+fhO4SaEHrUb5sZfz9wPue
        /+ujgIl1lU3AOr6JSASobe9epA2oeXv34TQ0rEA=
X-Google-Smtp-Source: AGRyM1uJgch5tZBtq7ZNZxzaBCqHBPG8c0/bMwS/nkKLlkiWwSCMepriBrNgZsEgJhC2dBczMrkfFCxcpJOMOKpnkxM=
X-Received: by 2002:a81:920e:0:b0:31e:7664:fa04 with SMTP id
 j14-20020a81920e000000b0031e7664fa04mr1861840ywg.385.1658338919663; Wed, 20
 Jul 2022 10:41:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: gavonkomi32@gmail.com
Received: by 2002:a05:7010:de0a:b0:2e8:7f1a:1f28 with HTTP; Wed, 20 Jul 2022
 10:41:59 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Wed, 20 Jul 2022 17:41:59 +0000
X-Google-Sender-Auth: HSPLTg-FBqDdYLtodapkaaTjLYw
Message-ID: <CA+rrxF1Cc9sHg6cDi91E4oNhnm0c3mAuR4cgiKeiX7-N171vmA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

5L2g5aW977yM5L2g5pS25Yiw5oiR5LmL5YmN55qE5Lik5p2h5raI5oGv5LqG5ZCX77yfDQo=
