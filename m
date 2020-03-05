Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D11317A748
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Mar 2020 15:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgCEOV1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Mar 2020 09:21:27 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:38388 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgCEOV1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2020 09:21:27 -0500
Received: by mail-qk1-f170.google.com with SMTP id j7so5155273qkd.5
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2020 06:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MhVGUJvIPGbdzNKJelW+M8GR3kzBeR3Kjkr0jj499vw=;
        b=VRexyQ7Ilyncwfj3r+R/KDKSRQeaiWMIbN8r18CpYQOvtlyufgVoa2zMro3BUik9/I
         cZk6Ni86rZ4o+8K+3OD6vQZX5cPoFZZSoGZsN4tdwcu7zs1KOIqCYm2LyMpTJlyx+8PH
         1pi5Cu4KbEe8HAbbUmbCLAxoaaFUd14Bj045q0M8bQ0qnWhYB8N4ShFb/AGOqDDuFhW9
         qBuir9ukd3V+JawAvDnTMiuzTcBPM1Rnh/nyzJ5fSTcTyRFxXy4qOxoHqGY/kAyoj/OG
         qHbTNbW0yH20xU9M+fYES1SSgMq4fTAjmNpYPkegg3K2KJYjZbvfME5L4Oc6vzlsZaYd
         9XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MhVGUJvIPGbdzNKJelW+M8GR3kzBeR3Kjkr0jj499vw=;
        b=aVbfNcdQJ+fmZPxOcRwLa6xEIYfCTRRv6iO/E77IrrYgJxlao3nt+vUPvWZ0DVlTkc
         55+pMvZOEayLpXhy09FppWhXlL2W99clD8CbAIFzKyJmFBkQzFF3FraqPwFj7q8MXULD
         LJIMCjJIxxbEOcgcg6abNCWivnlMorTW+M1Ar1COq2INkD+3B2UFHRkOsz26M4eY8YT3
         TmDlm0jn8lh19kVwK4IxmzFvcYjHmUz5IJyfkulmwI+QMiRSIBW7liv8CbAVyx+CayPB
         sar0egecRu3V/FufR3uLyVz82RtV00RoGJ14zEE/VzTSO2zESy7e+mjZJAEeXw0tvjL4
         Bbig==
X-Gm-Message-State: ANhLgQ3OuzukzkxwhPDsL0TAQa0SLj+dK9GgAz0RqyUy0FCJBFsnYOVW
        C3bD8slLC5WUWGBn6G5UcipbTwbFQRVYj/ClbHYhAE/g
X-Google-Smtp-Source: ADFU+vs8I66guCprASRBh+VOE7NKHVZlpDUFAHtVmgfdei0PrAIvrKoBNSXtDFRXwl9yLfw3p/YHDHsTypekidqE6P4=
X-Received: by 2002:a37:ac0c:: with SMTP id e12mr3904462qkm.97.1583418085155;
 Thu, 05 Mar 2020 06:21:25 -0800 (PST)
MIME-Version: 1.0
From:   Lars Pedersen <lapeddk@gmail.com>
Date:   Thu, 5 Mar 2020 15:21:13 +0100
Message-ID: <CAKd8=GszhQreaNiAkMa97wonApv_tpP8uxqreuHjUknqU-63uQ@mail.gmail.com>
Subject: 
To:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

index linux-fsdevel
